class CreateProposal < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.integer :product_id
      t.integer :version_number
      t.integer :project_id
    end
  end

  def self.down
    drop_table :proposals
  end
end
