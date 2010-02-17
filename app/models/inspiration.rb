class Inspiration < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :title
  
  def to_s
    title
  end
end
