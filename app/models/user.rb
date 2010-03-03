class User < ActiveRecord::Base
  has_many :projects,  :foreign_key => :creator_id
  has_many :proposals, :foreign_key => :creator_id
  has_many :comments,  :foreign_key => :creator_id

  acts_as_authentic
  acts_as_voter
  is_gravtastic!

  def to_s
    username
  end
end
