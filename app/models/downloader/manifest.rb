module Downloader
  class Manifest < Base
    def initialize
      @uri = URI.parse(ENV['ASSET_HOST'])
      @bucket_name = @uri.host
    end

    def download
      FileUtils.mkdir_p(Rails.root.join('public', 'dist'))
      file = bucket.file "#{@uri.path[1..-1]}/dist/manifest.json"
      file.download Rails.root.join('public', 'dist', 'manifest.json').to_s
    end
  end
end
