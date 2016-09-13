require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: "testing", email: "testing@gmail.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid user" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = ""
  	assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be unique" do
  	duplicate_user = @user.dup
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "email address should be saved as downcase" do
  	email_string = "Foo@Yahoo.CoM"
  	@user.email = email_string
  	@user.save

  	assert_equal email_string.downcase, @user.reload.email
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for user with nil digest" do
    assert_not @user.authenticated?('')
  end
end
