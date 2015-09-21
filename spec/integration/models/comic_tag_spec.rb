require 'rails_helper'
require 'shared_contexts'

RSpec.describe Tag, type: :model do
  include_context 'with common test comics'
  include_context 'with common test tags'

  it 'represents a unique mapping of comics to tags' do
    unpublished_comic.save
    published_comic.save
    tag_1.save

    expect {
      ComicTag.new(comic: unpublished_comic, tag: tag_1).save
    }.to change { ComicTag.count }.from(0).to(1)
    expect {
      ComicTag.new(comic: unpublished_comic, tag: tag_1).save
    }.not_to change { ComicTag.count }
    expect {
      ComicTag.new(comic: published_comic, tag: tag_1).save
    }.to change { ComicTag.count }.from(1).to(2)
  end
end
