require 'spec_helper'

describe 'routes for comics' do

  it 'routes to the latest comic' do
    { :get => '/comics/latest' }.should route_to 'comics#latest'
  end

  it 'routes root to the latest comic' do
    { :get => '/' }.should route_to 'comics#latest'
  end

  it 'routes to comics by slugs' do
    { :get => '/a_comic' }.should route_to 'comics#show_by_slug', :slug => 'a_comic'
  end

  it 'routes to the archive' do
    { :get => '/comics'}.should route_to 'comics#index'
  end

  it 'routes to comics by id' do
    { :get => '/comics/666' }.should route_to 'comics#show', :id => '666'
  end

  it 'routes to editing comics' do
    { :get => '/comics/666/edit' }.should route_to 'comics#edit', :id => '666'
  end

  it 'routes to updating comics' do
    { :put => '/comics/666' }.should route_to 'comics#update', :id => '666'
  end

  it 'routes to making new comics' do
    { :get => '/comics/new' }.should route_to 'comics#new'
  end

  it 'routes to creating comics' do
    { :post => '/comics' }.should route_to 'comics#create'
  end

  it 'routes to destroying a comic through a get route' do
    { :get => '/comics/666/destroy' }.should route_to "comics#destroy", :id => '666'
  end

  it 'routes to destroying a comic through a delete route' do
    { :delete => '/comics/666' }.should route_to "comics#destroy", :id => '666'
  end

  #FEED STUFF
  it 'routes to the atom feed' do
    { :get => '/comics/feed' }.should route_to 'comics#feed'
  end

  it 'routes to the atom feed from the root' do
    { :get => '/feed' }.should route_to 'comics#feed', 'format' => 'atom'
  end
end
