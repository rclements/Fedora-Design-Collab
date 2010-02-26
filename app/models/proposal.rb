class Proposal < ActiveRecord::Base
  belongs_to :project
  acts_as_voteable
  has_many :proposal_images
  has_many :comments, :as => :commentable
  validates_presence_of :content
  #acts_as_list  :scope => :parent_id
end
