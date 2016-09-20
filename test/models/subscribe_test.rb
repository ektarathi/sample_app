require 'test_helper'

class SubscribeTest < ActiveSupport::TestCase

  def setup
  	@user = Subscribe.new(first_name: "bob", last_name: "drake", email: "testing@gmail.com")
  end

  test "first name should be present" do
  	@user.first_name = ''
  	assert_not @user.valid?
  end

  test "last name should be present" do
  	@user.last_name = ''
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = ''
  	assert_not @user.valid?
  end

  test "email should be unique" do
  	duplicate_user = @user.dup
  	@user.save
  	assert_not duplicate_user.valid?
  end
end
