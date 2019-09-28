require 'rails_helper'

module Downloader
  RSpec.describe Manifest do
    describe '#download' do
      let(:downloader) { Downloader::Manifest.new }
      let(:bucket) { Google::Cloud::Storage::Bucket.new }
      let(:file) { Google::Cloud::Storage::File.new }
      before do
        allow(ENV).to receive(:[]).with('ASSET_HOST').and_return('https://example.com/hoge')
        allow(downloader).to receive(:bucket).and_return(bucket)
        allow(file).to receive(:name).and_return('hoge/dist/manifest.json')
      end

      it do
        expect(bucket).to receive(:file).with('hoge/dist/manifest.json').and_return(file)
        expect(file).to receive(:download).with(Rails.root.join('public/dist/manifest.json').to_s)
        downloader.download
      end
    end
  end
end
