# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'
require 'remarkable_rails'
require "authlogic/test_case"
require "machinist"
require "blueprint"
require "faker"

# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }
  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  #
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end
def create_user_session(_user = nil)
  unless _user
    _user = User.make
  end
  UserSession.create(:username => _user.username, :password => 'password', :password_confirmation => 'password')
end
def create_proposal_with_owner(user=nil, proposal=nil)
  unless user
    user = User.make
  end
  unless proposal
  proposal = Proposal.make
  end
  user.has_role!(:owner, proposal)
  [proposal, user]
end
def create_project_with_owner(user=nil, project=nil)
  unless user
    user = User.make
  end
  unless project
  project = Project.make
  end
  user.has_role!(:owner, project)
  [project, user]
end
def create_inspiration_with_owner(user=nil, inspiration=nil)
  unless user
    user = User.make
  end
  unless inspiration
  inspiration = Inspiration.make
  end
  user.has_role!(:owner, inspiration)
  [inspiration, user]
end
def watch_with_watcher(user=nil, project=nil)
  unless user
    user = User.make
  end
  unless project
  project = Project.make
  end
  user.has_role!(:watcher, project)
  [project, user]
end
