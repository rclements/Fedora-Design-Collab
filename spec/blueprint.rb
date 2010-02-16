blueprint :project do
  Project.create!(:title => "this is a project", :description => "Like I said, a project.")
end
blueprint :user do
  User.create!(:username => "example", :password => "password", :email => "name@example.com")
end
blueprint :user_session do
  UserSession.create!(:username => "example", :password => "password")
end
