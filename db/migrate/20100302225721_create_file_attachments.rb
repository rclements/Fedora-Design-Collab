class CreateFileAttachments < ActiveRecord::Migration
  def self.up
    create_table :file_attachments do |t|
      t.integer :proposal_id
      t.string :image_file_file_name
      t.string :image_file_content_type
      t.integer :image_file_file_size
      t.datetime :image_file_updated_at
    end
  end

  def self.down
    drop_table :file_attachments
  end
end
