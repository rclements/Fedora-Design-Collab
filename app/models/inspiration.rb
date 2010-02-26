class Inspiration < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :title
  has_many :inspiration_images
 
  def to_s
    title
  end
end
