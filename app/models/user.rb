class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_voter
  is_gravtastic!

  has_many :projects
end
