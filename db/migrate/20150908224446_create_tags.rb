class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :tag
    end

    create_table :comic_tags do |t|
      t.references :comic, index: true
      t.references :tag,   index: true
    end
  end

  def self.down
    drop_table :tags
    drop_table :comic_tags
  end
end
