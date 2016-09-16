require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
  	@article = Article.new(title: "title", text: "text content")
  end

  test "title should be present" do
  	@article.title = ""
  	assert_not @article.valid?
  end

  test "text should be present" do
    @article.text = "     "
    assert_not @article.valid?
  end
end
