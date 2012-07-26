class AddGoodyFileToGoody < ActiveRecord::Migration
  def self.up
    add_column :goodies, :goody_file_file_name, :string
    add_column :goodies, :goody_file_file_size, :integer
    add_column :goodies, :goody_file_content_type, :string
  end

  def self.down
    remove_column :goodies, :goody_file_content_type
    remove_column :goodies, :goody_file_file_size
    remove_column :goodies, :goody_file_file_name
  end
end
