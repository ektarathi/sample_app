require 'test_helper'

class ArticlesCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:stacy)
    @article = articles(:one)
  end

  test "create article after succesfully logged in" do
    get new_article_path
    assert_not is_logged_in?
    get login_path
    assert_response :success
    assert_template 'sessions/new'
    post login_path, session: {email: @user.email, password: 'password'}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_response :success
    assert_template 'users/show'
    post articles_path, article: { title: @article.title, text: @article.text}
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end
end
