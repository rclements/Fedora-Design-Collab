class Proposal < ActiveRecord::Base
  belongs_to :project
  has_many :comments, :as => :commentable
  #acts_as_list  :scope => :parent_id
end
