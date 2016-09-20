require 'test_helper'

class SubscribesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_subscribe_path
    assert_response :success
  end
end
