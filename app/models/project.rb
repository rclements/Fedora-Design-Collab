class Project < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :proposals
  has_many :comments, :as => :commentable
  acts_as_authorization_object
  has_many :collaborators
  
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

  # NOTE: This doesn't paginate so nicely, but we probably won't have enough of these for it to matter ever...
  def collaborators
    collab_roles = accepted_roles.for_name("collaborator")
    User.find_by_sql("SELECT * FROM users INNER JOIN roles_users ON roles_users.user_id = users.id WHERE roles_users.role_id IN (12)")
  end
end
