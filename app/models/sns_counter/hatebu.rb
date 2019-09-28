require 'uri'

module SnsCounter
  class Hatebu
    def count!
      update_posts = []
      updated_at = Time.zone.now
      # はてぶの1リクエストでの取得制限のため、50URLずつ実行する
      # http://developer.hatena.ne.jp/ja/documents/bookmark/apis/getcount
      posts.each_slice(50) do |post50|
        res = request(post50.map{|post| post[0]})
        JSON.parse(res.response_body).each do |target, count|
          update_posts << { id: posts.dig(target, 'id'), hatebu_count: count, created_at: posts.dig(target, 'created_at'), updated_at: updated_at }
        end
        sleep 1
      end
      ::Post.upsert_all(update_posts)
    end

    private
    def posts
      return @posts if @posts
      @posts = {}
      # public post with sns count
      Post.all.each do |post|
        @posts[post.url] = post.attributes
      end
      @posts
    end

    def request(urls)
      Typhoeus.get("https://bookmark.hatenaapis.com/count/entries?#{urls.map{|url| "url=#{URI.escape(url)}"}.join('&')}")
    end
  end
end
