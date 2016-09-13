require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  test "should get all articles" do
  	get root_path
  	assert_response :success
  end
end
