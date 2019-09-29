require 'uri'

module SnsCounter
  class Facebook
    def count!
      update_posts = []
      updated_at = Time.zone.now
      # Facebookの1リクエストでの取得制限のため、50URLずつ実行する
      posts.each_slice(50) do |post50|
        res = request(post50.map{|post| post[0]})
        JSON.parse(res.response_body).each do |target, info|
          update_posts << { id: posts.dig(target, 'id'), facebook_count: info.dig('og_object', 'engagement', 'count'), created_at: posts.dig(target, 'created_at'), updated_at: updated_at }
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
      # FACEBOOK_ACCESS_TOKENは以下のURLで取得しておく
      # https://graph.facebook.com/oauth/access_token?client_id={アプリID}&client_secret={app_secret}&grant_type=client_credentials
      Typhoeus.get("https://graph.facebook.com/v4.0?ids=#{urls.join(',')}&fields=og_object{engagement},engagement&access_token=#{ENV['FACEBOOK_ACCESS_TOKEN']}")
    end
  end
end
