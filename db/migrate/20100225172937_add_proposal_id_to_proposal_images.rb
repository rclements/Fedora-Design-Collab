class AddProposalIdToProposalImages < ActiveRecord::Migration
  def self.up
    add_column :proposal_images, :proposal_id, :integer
  end

  def self.down
    remove_column :proposal_images, :proposal_id
  end
end
