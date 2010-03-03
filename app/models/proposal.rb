class Proposal < ActiveRecord::Base
  acts_as_voteable
  extend VoteFuHighestExtension

  belongs_to :project
  belongs_to :creator, :class_name => "User"
  has_many :proposal_images
  has_many :file_attachments
  has_many :comments, :as => :commentable

  validates_presence_of :content

end
