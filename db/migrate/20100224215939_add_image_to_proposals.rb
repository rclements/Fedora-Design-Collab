class AddImageToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :image_file_file_name, :string
    add_column :proposals, :image_file_content_type, :string
    add_column :proposals, :image_file_file_size, :integer
  end

  def self.down
    remove_column :proposals, :image_file_file_name
    remove_column :proposals, :image_file_content_type
    remove_column :proposals, :image_file_file_size
  end
end
