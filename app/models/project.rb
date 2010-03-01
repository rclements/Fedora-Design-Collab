class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :proposals
  has_many :comments, :as => :commentable
  #has_many :collaborators
  has_many :inspirations

  validates_presence_of :title
  
  def to_s
    title
  end

  def highest_voted_proposal
    proposals.highest_tally(:limit => 1).first rescue nil
  end
end
