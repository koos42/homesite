class RenameComicsPubishToComicsPublish < ActiveRecord::Migration
  def self.up
    rename_column :comics, :pubish, :publish
  end

  def self.down
    rename_column :comics, :publish, :pubish
  end
end
