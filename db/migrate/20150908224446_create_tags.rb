class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag
    end

    create_join_table :comics, :tags do |t|
      t.index [:comic_id, :tag_id]
      t.index [:tag_id, :comic_id]
    end
  end
end
