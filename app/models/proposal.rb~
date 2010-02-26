class Proposal < ActiveRecord::Base
  belongs_to :project
  has_many :comments, :as => :commentable
  validates_presence_of :content
  #acts_as_list  :scope => :parent_id
end
