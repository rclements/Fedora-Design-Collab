class CreateInspirationImages < ActiveRecord::Migration
  def self.up
    create_table :inspiration_images do |t|
      t.string :image_file_file_name
      t.string :image_file_content_type
      t.integer :image_file_file_size
      t.datetime :image_file_updated_at
      t.integer :inspiration_id
    end
  end

  def self.down
    drop_table :inspiration_images
  end
end
