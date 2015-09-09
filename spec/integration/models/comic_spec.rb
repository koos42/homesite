require 'rails_helper'

RSpec.describe Comic, type: :model do
  let(:comic_1) do
    Comic.new( title: 'test',
               blurb: 'test blurb',
               slug: 'test-slug',
               date: Date.today)
  end

  let(:comic_2) do
    Comic.new( title: 'test 2',
               blurb: 'test 2 blurb',
               slug: 'test-2-slug',
               date: Date.today)
  end

  it 'creates and retrieves comics' do
    expect(comic_1.save).to be_truthy
    expect(comic_2.save).to be_truthy
    expect(Comic.find_by_slug('test-slug')).to eq comic_1
  end

  it 'figures out if a comic is to be published' do
    comic_1.publish = true
    comic_1.date = Date.today - 1
    comic_1.save
    expect(comic_1.published?).to be_truthy
  end
end
