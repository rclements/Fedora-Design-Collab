ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'pages', :action => 'home'
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.resources :projects
  map.resources :proposals
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
