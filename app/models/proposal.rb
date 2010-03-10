class Proposal < ActiveRecord::Base
  acts_as_voteable
  acts_as_authorization_object
  extend VoteFuHighestExtension

  belongs_to :project
  belongs_to :creator, :class_name => "User"
  has_many :proposal_images
  has_many :file_attachments
  has_many :comments, :as => :commentable
  has_many :inspirations
  
  validates_presence_of :content
  validates_presence_of :title

  def to_s
    title
  end
end
