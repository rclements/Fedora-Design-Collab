class Upload < ActiveRecord::Base

  has_attachment :content_type => :image, 
    :storage => :file_system, 
    :max_size => 800.kilobytes,
    :resize_to => '200x150>',
    :thumbnails => { :thumb => '80x80>' }

  validates_as_attachment

end
