class Project < ActiveRecord::Base
  belongs_to :creator
  #has_many :proposals
  #has_many :collaborators
  #has_many :inspirations
  
  def to_s
    title
  end
end
