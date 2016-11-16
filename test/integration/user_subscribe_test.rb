require 'test_helper'

class UserSubscribeTest < ActionDispatch::IntegrationTest

  def setup
    @subscribe = subscribes(:first)
    @mail_chimp = Mailchimp::API.new('16bf11d4c6a9a81fb1c6ed8b7fd9b059-us14')
    @list_name = @mail_chimp.lists.list['data'].first['id']
  end

  test "valid user subscription" do
    get new_subscribe_path
    assert_response :success
    assert_template 'subscribes/new'
    post subscribes_path, subscribe: { first_name: @subscribe.first_name, last_name: @subscribe.last_name, email: @subscribe.email}
    assert @subscribe.save
    @mail_chimp.lists.subscribe(@list_name, { first_name: @subscribe.first_name, last_name: @subscribe.last_name, email: @subscribe.email })
    assert_response :success
  end
end
