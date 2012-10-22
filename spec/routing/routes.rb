require 'spec_helper'

describe 'routes for comics' do
  it 'routes to comics by slugs' do
    { :get => '/a_comic' }.should route_to 'comics#show_by_slug', :slug => 'a_comic'
  end
end
