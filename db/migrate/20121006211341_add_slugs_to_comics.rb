class AddSlugsToComics < ActiveRecord::Migration
  def self.up
    add_column :comics, :slug, :string

    comics = Comic.find :all
    comics.each do |c|
      c.save
    end

    add_index :comics, :slug, :unique => true
  end

  def self.down
    remove_index  :comics, :slug
    remove_column :comics, :slug
  end
end
