Webcomic::Application.routes.draw do

  root :to => "comics#latest"

  get "pages/about"

# Users
  match 'users/sign_up' => 'comics#latest'
  post 'users' => 'users#create'
  devise_for :users
  resources :users

# Goodies
  match 'goodies/:id/destroy' => 'goodies#destroy', as: 'destroy_goody'
  resources :goodies

# Tags
  match 'tags/:id/destroy' => 'tags#destroy', as: "destroy_tag"
  resources :tags

# Comics
  match 'comics/latest' => 'comics#latest'
  match 'comics/feed' => 'comics#feed'
  match 'feed' => 'comics#feed',
        :as => 'feed',
        :defaults => { :format => 'atom' }
  match 'comics/:id/destroy' => 'comics#destroy'

  resources :comics
  get '/:slug' => 'comics#show_by_slug', as: 'show_by_slug'

# Catch all for custom 404/500s
  get "errors/four_oh_four"
  get "errors/five_hundred"
  match '*a', :to => 'errors#four_oh_four'
end
