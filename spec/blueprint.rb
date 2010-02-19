require 'machinist/active_record'

Project.blueprint do
  title { "this is a project" }
  description { "Like I said, a project" }
end

Inspiration.blueprint do
  title { "this is an inspiration" }
  description { "Like Josh said, an inspiration" }
end

Proposal.blueprint do
  project { Project.make }
  version_number { "1" }
  content { "stuff said" }
end

User.blueprint do
  username { 'jimbob' }
  password { 'password' }
  password_confirmation { 'password' }
  email { 'email@email.com' }
end
Comment.blueprint do
  comment { "blah blah blah" }
end
