class AddProjectIdToInspirations < ActiveRecord::Migration
  def self.up
    add_column :inspirations, :project_id, :integer
  end

  def self.down
    remove_column :inspirations, :project_id
  end
end
