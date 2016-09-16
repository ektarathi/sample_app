require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @article = articles(:one)
    @other_article = articles(:two)
    @user = users(:stacy)
    @user = users(:milleytest)
  end

  test "should not get new when not logged in" do
    get new_article_path
    assert_not is_logged_in?
    assert_redirected_to login_url
  end

  test "should get all articles" do
    get root_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_article_path(@article)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch article_path(@article), article: { title: @article.title, text: @article.text}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not edit other user article" do
    log_in_as(@user)
    get edit_article_path(@article)
    assert_not_equal @user.id, @article.user.id
    assert_redirected_to root_url

    #puts "checking id of resource"
    #puts @user.id
    #puts "article use id data"
    #puts @article.user.id
  end

  test "should not update other user article" do
    log_in_as(@user)
    patch article_path(@article), article: { title: @article.title, text: @article.text}
    assert_not_equal @user.id, @article.user.id
    assert_redirected_to root_url
  end
end
