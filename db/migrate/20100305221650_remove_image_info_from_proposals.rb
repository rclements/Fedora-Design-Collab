class RemoveImageInfoFromProposals < ActiveRecord::Migration
  def self.up
    remove_column :proposals, :image_file_file_name
    remove_column :proposals, :image_file_content_type
    remove_column :proposals, :image_file_file_size
  end

  def self.down
    add_column :proposals, :image_file_filename, :string
    add_column :proposals, :image_file_content_type, :string
    add_column :proposals, :image_file_file_size, :integer
  end
end
