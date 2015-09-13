RSpec.shared_context 'with common test comics', :common_comics do
  let(:published_comic) do
    Comic.new( title: 'test',
               blurb: 'test blurb',
               slug: 'test-slug',
               date: Date.today,
               publish: true)
  end

  let(:unpublished_comic) do
    Comic.new( title: 'test 2',
               blurb: 'test 2 blurb',
               slug: 'test-2-slug',
               date: Date.today,
               publish: false)
  end
end

RSpec.shared_context 'with common test tags', :common_tags do
  let(:tag_1) { Tag.new(tag: 'one') }
  let(:tag_2) { Tag.new(tag: 'two') }
end
