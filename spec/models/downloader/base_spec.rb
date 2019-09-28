require 'rails_helper'

module Downloader
  RSpec.describe Base do
    describe '#download' do
      let(:downloader) { Downloader::Base.new('a') }
      let(:storage) { double }
      let(:bucket) { Google::Cloud::Storage::Bucket.new }
      let(:file) { Google::Cloud::Storage::File.new }
      let(:storage_path) { 'path/to/storage_path.txt' }
      let(:download_path) { 'path/to/download_path' }
      before do
        allow(ENV).to receive(:[]).with('ASSET_HOST').and_return('https://example.com/hoge')
        allow(downloader).to receive(:storage).and_return(storage)
        allow(storage).to receive(:bucket).and_return(bucket)
        allow(file).to receive(:name).and_return(storage_path)
      end

      it do
        expect(bucket).to receive(:file).with(storage_path).and_return(file)
        expect(file).to receive(:download).with("#{download_path}/storage_path.txt")
        downloader.download(storage_path, download_path)
      end
    end
  end
end
