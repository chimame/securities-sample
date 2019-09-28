require "google/cloud/storage"

module Downloader
  class Base
    def initialize(bucket_name)
      @bucket_name = bucket_name
    end

    def download(storage_path, download_path)
      file = bucket.file storage_path
      file.download File.join(download_path, File.basename(file.name)).to_s
    end

    private
    def storage
      # set GOOGLE_APPLICATION_CREDENTIALS
      @storage ||= Google::Cloud::Storage.new(
        project_id: ENV['PROJECT_ID']
      )
    end

    def bucket
      @bucket ||= storage.bucket @bucket_name
    end
  end
end
