class AddHasOriginalToComics < ActiveRecord::Migration
  def self.up
    add_column :comics, :has_original, :boolean
  end

  def self.down
    remove_column :comics, :has_original
  end
end
