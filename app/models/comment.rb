class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :creator, :class_name => "User"

  validates_presence_of :comment  
end
