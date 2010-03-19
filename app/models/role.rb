class Role < ActiveRecord::Base
  acts_as_authorization_role

  named_scope :for_authorizable_type, lambda{|klass| { :conditions => ["authorizable_type = ?", klass]} }
  named_scope :for_name, lambda{|name| { :conditions => ["name = ?", name]} }
end
