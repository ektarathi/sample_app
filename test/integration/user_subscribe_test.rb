require 'test_helper'

class UserSubscribeTest < ActionDispatch::IntegrationTest

  test "valid user subscription" do
    get new_subscribe_path
    assert_response :success
    assert_template 'subscribes/new'
    post subscribes_path, subscribe: { first_name: 'Bob', last_name: 'Miller', email: 'bobmiller@gmail.com'}

    Mailchimp.stubs(:subscribe).returns(200)
    #post :signup, {:EMAIL => "my_email@something.com"}
    assert_response :success
    assert_redirected_to thank_you_path
    follow_redirect!
    assert_response :success
    assert_template 'static_pages/thanks'
  end
end
