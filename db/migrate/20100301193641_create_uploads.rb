class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
    	t.column :user_id,  :integer
      t.column :content_type, :string
      t.column :filename, :string
      t.column :thumbnail, :string
      t.column :size, :integer
      t.column :width, :integer
      t.column :height, :integer

      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end
end

