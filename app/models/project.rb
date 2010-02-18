class Project < ActiveRecord::Base
  belongs_to :creator
  validates_presence_of :title
  has_many :proposals
  has_many :comments, :as => :commentable
  #has_many :collaborators
  has_many :inspirations
  
  def to_s
    title
  end
end
