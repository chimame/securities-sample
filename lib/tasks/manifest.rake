namespace :manifest do
  desc "Storageにアップロードしているmanifest.jsonをダウンロードする"
  task download: :environment do
    Downloader::Manifest.new.download
  end
end
