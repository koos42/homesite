require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag_1) { Tag.new(tag: 'one') }
  let(:tag_2) { Tag.new(tag: 'two') }

  it 'creates, stores, and fetches tags' do
    expect(tag_1.save).to be_truthy
    expect(tag_2.save).to be_truthy
    expect(Tag.find_by_id(1)).to eq tag_1
  end
end
