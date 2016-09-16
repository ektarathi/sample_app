require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:stacy)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
  	get edit_user_path(@user)
  	assert_response :success
  	assert_template 'users/edit'
  	patch user_path(@user), user: { name: '', email: @user.email, password: 'password', password_confirmation: 'password'}

  	assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "milley drake"
  	email = "milley.drake@gmail.com"
    patch user_path(@user), user: { name:  name,
                                              email: email,
                                              password:              "password",
                                              password_confirmation: "password" }
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
