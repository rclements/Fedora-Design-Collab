class User < ActiveRecord::Base
  acts_as_authentic
  is_gravtastic!
  has_many :projects
end
