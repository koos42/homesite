require 'spec_helper'

describe 'routes for comics' do
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
end
