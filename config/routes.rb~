ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'pages', :action => 'home'
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.resources :projects
  map.resources :proposals
  map.resources :inspirations
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :comments
  map.resources :users do |user|
    user.resources :votes
    user.resources :voteable do |mv|
      mv.resources :votes
    end
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
