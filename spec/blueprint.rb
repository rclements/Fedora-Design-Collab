require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  username { Faker::Internet.user_name }
  email { Faker::Internet.email }
end

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
  username
  password { 'password' }
  password_confirmation { 'password' }
  email
end

Comment.blueprint do
  comment { "blah blah blah" }
end
