class ProposalImage < ActiveRecord::Base
  belongs_to :proposal
  has_attached_file :image_file, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_presence_of :image_file_file_name
end
