class CreateGoodies < ActiveRecord::Migration
  def self.up
    create_table :goodies do |t|
      t.string :name
      t.string :desc

      t.timestamps
    end
  end

  def self.down
    drop_table :goodies
  end
end
