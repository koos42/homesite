require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test "should get about" do
    get :about
    assert_response :success
  end

end
