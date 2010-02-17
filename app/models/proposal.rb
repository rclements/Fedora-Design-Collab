class Proposal < ActiveRecord::Base
  belongs_to :project
#  acts_as_list  :scope => :parent_id
  
end
