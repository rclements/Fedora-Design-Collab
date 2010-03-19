class ChangeFileAttachmentFromImage < ActiveRecord::Migration
  def self.up
    remove_column :file_attachments, :image_file_file_name
    remove_column :file_attachments, :image_file_content_type
    remove_column :file_attachments, :image_file_file_size
    remove_column :file_attachments, :image_file_updated_at
    add_column :file_attachments, :attachment_file_file_name, :string
    add_column :file_attachments, :attachment_file_file_content_type, :string
    add_column :file_attachments, :attachment_file_file_size, :integer
    add_column :file_attachments, :attachment_file_file_updated_at, :datetime
  end

  def self.down
    add_column :file_attachments, :image_file_file_name, :string
    add_column :file_attachments, :image_file_content_type, :string
    add_column :file_attachments, :image_file_file_size, :integer
    add_column :file_attachments, :image_file_updated_at, :datetime
    remove_column :file_attachments, :attachment_file_file_name
    remove_column :file_attachments, :attachment_file_file_content_type
    remove_column :file_attachments, :attachment_file_file_size
    remove_column :file_attachments, :attachment_file_file_updated_at
  end
end
