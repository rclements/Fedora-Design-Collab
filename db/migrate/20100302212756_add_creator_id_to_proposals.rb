class AddCreatorIdToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :creator_id, :integer
  end

  def self.down
    remove_column :proposals, :creator_id
  end
end
