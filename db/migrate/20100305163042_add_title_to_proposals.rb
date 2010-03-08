class AddTitleToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :title, :string
  end

  def self.down
    remove_column :proposals, :title
  end
end
