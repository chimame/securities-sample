require 'rails_helper'

RSpec.describe 'manifest:download', type: :rake do
  let(:downloader) { Downloader::Manifest.new }
  before do
    allow(ENV).to receive(:[]).with('ASSET_HOST').and_return('https://example.com/asset')
    allow(Downloader::Manifest).to receive(:new).and_return(downloader)
  end
  subject(:task) { Rake.application['manifest:download'] }

  it do
    expect(downloader).to receive(:download)
    task.invoke
  end 
end
