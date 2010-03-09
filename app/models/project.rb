class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :proposals
  has_many :comments, :as => :commentable
  #has_many :collaborators

  validates_presence_of :title

  def to_s
    title
  end

  def highest_voted_proposal
    proposals.highest_tally(:limit => 1).first rescue nil
  end

  def project_image
    highest_voted_proposal.proposal_images.first.image_file rescue nil
  end
end
