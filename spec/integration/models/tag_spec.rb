require 'rails_helper'
require 'shared_contexts'

RSpec.describe Tag, type: :model do
  include_context 'with common test comics'
  include_context 'with common test tags'

  let(:published_comic) do
    Comic.new().tap do |c|
      c.title= "test1"
      c.slug=  "test1"
      c.blurb= "test blurb"
      c.date= Date.today
      c.publish= false
    end
  end

  let(:unpublished_comic) do
    Comic.new.tap do |c|
      c.title= "test2",
      c.slug=  "test2",
      c.blurb= "test blurb"
      c.date= Date.today,
      c.publish= false
    end
  end

  it 'creates, stores, and fetches tags' do
    expect(tag_1.save).to be_truthy
    expect(tag_2.save).to be_truthy
    expect(Tag.find_by_id(1)).to eq tag_1
  end

  it 'can retrieve comics by tag' do
    tag_1.save
    tag_2.save
    published_comic.save
    unpublished_comic.save
    published_comic = Comic.find_by_id(1)
    unpublished_comic = Comic.find_by_id(2)
    published_comic.tags << tag_1
    tag_2.comics << unpublished_comic

    expect(unpublished_comic.tags).to eq [ tag_2 ]
    expect(tag_1.comics).to eq [ published_comic ]
  end

  it 'treats #comics as a set' do
    tag_1.save
    published_comic.save
    published_comic.tags << tag_1
    tag_1.comics << published_comic
    tag_1.comics << published_comic

    expect(tag_1.comics).to eq [ published_comic ]
  end
end
