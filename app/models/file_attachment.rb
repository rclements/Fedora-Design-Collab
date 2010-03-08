class FileAttachment < ActiveRecord::Base
  belongs_to :proposal
  has_attached_file :attachment_file
end
