class AddCreatedAtToProposals < ActiveRecord::Migration
  def self.up
  add_column :proposals, :created_at, :datetime
  end

  def self.down
  remove_column :proposals, :created_at
  end
end
