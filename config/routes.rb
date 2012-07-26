Webcomic::Application.routes.draw do

  root :to => "comics#latest"

  get "pages/about"

# Users
  match 'users/sign_up' => 'comics#latest'
  post 'users' => 'users#create'
  devise_for :users
  resources :users

# Comics
  match 'comics/feed' => 'comics#feed'
  match 'comics/latest' => 'comics#latest'
  match 'feed' => 'comics#feed',
        :as => 'feed',
        :defaults => { :format => 'atom' }
  match 'comics/:id/destroy' => 'comics#destroy'

  resources :comics

# Goodies
  match 'goodies/:id/destroy' => 'goodies#destroy', :as => 'destroy_goody'
  resources :goodies

  get "errors/four_oh_four"
  get "errors/five_hundred"
  match '*a', :to => 'errors#four_oh_four'
end
