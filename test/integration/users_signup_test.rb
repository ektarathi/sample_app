require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    post users_path, user: { name:  "",
                       email: "user@invalid",
                       password:              "password",
                       password_confirmation: "password" }
    assert_template 'users/new'
    assert_response :success
  end

  test "valid signup information with account activation" do
    get signup_path
    post users_path, user: { name:  "Example User",
                       email: "user@example.com",
                       password:              "password",
                       password_confirmation: "password" }
    #assert_response :redirect
    #follow_redirect!
    #assert_response :success
    
    # Exactly 1 message is delievered.
    assert_equal 1, ActionMailer::Base.deliveries.size
    # the Users controller’s create action defines an @user variable, so we can access it in the test using assigns(:user)
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    # Commenting the logged_in as we are activating account first for the user before logging into the portal.
    #assert is_logged_in?
  end
end
