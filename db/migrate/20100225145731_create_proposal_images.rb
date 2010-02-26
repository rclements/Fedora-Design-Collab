class CreateProposalImages < ActiveRecord::Migration
  def self.up
    create_table :proposal_images do |t|
      t.string :image_file_file_name
      t.string :image_file_content_type
      t.integer :image_file_file_size
      t.datetime :image_file_updated_at
    end
  end

  def self.down
    drop_table :proposal_images
  end
end
