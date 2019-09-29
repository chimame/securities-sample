require 'rails_helper'

module SnsCounter
  RSpec.describe Facebook do
    describe '#count!' do
      before do
        Post.insert_all([
          {url: "http://example.com/hoge", created_at: '2019-09-28', updated_at: '2019-09-28'},
          {url: "http://example.com/fuga", created_at: '2019-09-28', updated_at: '2019-09-28'}
        ])
        allow(Typhoeus).to receive(:get).and_return(Typhoeus::Response.new(code: 200, body: {"http://example.com/fuga" => {"og_object" => {"engagement" => {"count" => 2}}}, "http://example.com/hoge" => {"og_object" => {"engagement" => {"count" => 1}}}}.to_json))
      end

      it do
        Facebook.new.count!
        expect(Post.pluck(:url, :facebook_count)).to match_array([
          ["http://example.com/hoge", 1],
          ["http://example.com/fuga", 2]
        ])
      end
    end
  end
end
