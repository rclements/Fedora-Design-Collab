class Comment < ActiveRecord::Base
  validates_presence_of :comment  
  belongs_to :commentable, :polymorphic => true
  belongs_to :creator, :class_name => "User"
end
