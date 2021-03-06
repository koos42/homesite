require 'rails_helper'
require 'shared_contexts'

RSpec.describe Comic, type: :model do
  include_context 'with common test comics'
  include_context 'with common test tags'

  it 'creates and retrieves comics' do
    expect(published_comic.save).to be_truthy
    expect(unpublished_comic.save).to be_truthy
    expect(Comic.find_by_slug('test-slug')).to eq published_comic
  end

  it 'figures out if a comic is to be published' do
    published_comic.publish = true
    published_comic.date = Date.today - 1
    published_comic.save
    expect(published_comic.published?).to be_truthy
  end

  it 'has many tags' do
    tag_1.save
    tag_2.save
    published_comic.tags += [ tag_1, tag_2 ]
    expect(published_comic.tags).to eq [ tag_1, tag_2 ]
  end

  describe "related comics" do
    before do
      tag_1.save
      tag_2.save
      published_comic.tags += [ tag_1, tag_2 ]
      another_comic.tags += [ tag_1 ]
      other_comic.tags += [ tag_2 ]
      unpublished_comic.tags += [ tag_2, tag_1 ]

      another_comic.save
      other_comic.save
      published_comic.save
      unpublished_comic.save
    end

    it 'can get related comics without duplicates' do
      titles = published_comic.related_comics(5).map(&:title)
      expect(titles.count).to eq 2
    end

    it 'does not include itself or unpublished comics' do
      titles = published_comic.related_comics(5).map(&:title)
      expect(titles.count).to eq 2
      expect(titles).not_to include(unpublished_comic.title)
      expect(titles).not_to include(published_comic.title)
    end

    it 'may include comics from all tags that a comic has' do
      titles = published_comic.related_comics(5).map(&:title)
      expect(titles.count).to eq 2
      expect(titles).to include(another_comic.title)
      expect(titles).to include(other_comic.title)
    end

    it 'onyl includes up to `n` related comics' do
      titles = published_comic.related_comics(1)
      expect(titles.count).to eq 1
    end
  end
end
