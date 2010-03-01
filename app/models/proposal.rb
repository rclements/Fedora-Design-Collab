class Proposal < ActiveRecord::Base
  acts_as_voteable
  belongs_to :project
  has_many :proposal_images
  has_many :comments, :as => :commentable

  validates_presence_of :content
end
