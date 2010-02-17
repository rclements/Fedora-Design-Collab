class ProjectId < ActiveRecord::Migration
  def self.up
    add_column :proposals, :project_id, :integer
  end

  def self.down
    remove_column :proposals, :project_id
  end
end
