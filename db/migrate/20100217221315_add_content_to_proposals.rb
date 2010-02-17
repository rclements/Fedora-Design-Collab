class AddContentToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :content, :text
  end

  def self.down
    remove_column :proposals, :content
  end
end
