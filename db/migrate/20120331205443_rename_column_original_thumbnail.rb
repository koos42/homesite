class RenameColumnOriginalThumbnail < ActiveRecord::Migration
  def self.up
    change_table :comics do |t|
      t.rename :original_photo_file_name, :thumbnail_file_name
      t.rename :original_photo_content_type, :thumbnail_content_type
      t.rename :original_photo_file_size, :thumbnail_file_size
    end

    remove_column :comics, :original_date
    remove_column :comics, :has_original
  end

  def self.down
    change_table :comics do |t|
      t.rename :thumbnail_file_name, :original_photo_file_name
      t.rename :thumbnail_content_type, :original_photo_content_type
      t.rename :thumbnail_file_size, :original_photo_file_size
      t.date :original_date
      t.boolean :has_original
    end
  end
end
