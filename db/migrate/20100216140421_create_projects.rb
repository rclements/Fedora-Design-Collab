class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.integer :creator_id
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
