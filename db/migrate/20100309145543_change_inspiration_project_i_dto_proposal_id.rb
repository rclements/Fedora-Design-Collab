class ChangeInspirationProjectIDtoProposalId < ActiveRecord::Migration
  def self.up
    remove_column :inspirations, :project_id
    add_column :inspirations, :proposal_id, :integer
  end

  def self.down
    add_column :inspirations, :project_id, :integer
    remove_column :inspirations, :proposal_id
  end
end
