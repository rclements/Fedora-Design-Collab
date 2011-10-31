class Inspiration < ActiveRecord::Base
  belongs_to :proposal
  has_many :inspiration_images
  acts_as_authorization_object

  validates_presence_of :title

  def to_s
    title
  end
end
