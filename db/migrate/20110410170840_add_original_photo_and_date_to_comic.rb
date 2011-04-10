class AddOriginalPhotoAndDateToComic < ActiveRecord::Migration
  def self.up
    add_column :comics, :original_date, :date
    add_column :comics, :original_photo_file_name, :string
    add_column :comics, :original_photo_content_type, :string
    add_column :comics, :original_photo_file_size, :integer
  end

  def self.down
    remove_column :comics, :original_date
    remove_column :comics, :original_photo_file_name
    remove_column :comics, :original_photo_content_type
    remove_column :comics, :original_photo_file_size
  end
end
