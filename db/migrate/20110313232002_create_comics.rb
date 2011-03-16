class CreateComics < ActiveRecord::Migration
  def self.up
    create_table :comics do |t|
      t.string :title
      t.date :date
      t.boolean :pubish
      t.text :blurb

      t.timestamps
    end
  end

  def self.down
    drop_table :comics
  end
end
