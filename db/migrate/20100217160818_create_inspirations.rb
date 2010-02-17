class CreateInspirations < ActiveRecord::Migration
  def self.up
    create_table :inspirations do |t|
      t.string :title
      t.string :description
      t.string :url
    end
  end

  def self.down
    drop_table :inspirations
  end
end
