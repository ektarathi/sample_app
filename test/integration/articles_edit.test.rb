require 'test_helper'

class ArticlesEditTest < ActionDispatch::IntegrationTest

  def setup
    @article = articles(:one)
    @user = users(:stacy)
  end

  test "successful edit article" do
  	log_in_as(@user)
  	assert_response :success
  	get edit_article_path(@article)
  	assert_template 'articles/edit'
  	patch user_path(@user), article: { title: @article.title, text: @article.text}

  	assert_redirected_to root_url
  	assert_response :success
  	@article.reload
  end

  test "unsuccesful edit article" do
  	log_in_as(@user)
  	assert_response :success
  	get edit_article_path(@article)
  	assert_template 'articles/edit'
  	patch user_path(@user), article: { title: '', text: @article.text}

  	assert_template 'articles/edit'
  end
 end
