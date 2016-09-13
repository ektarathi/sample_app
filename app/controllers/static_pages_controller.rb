class StaticPagesController < ApplicationController
  def home
  	@articles = Article.all
  end

  def help
  end

  def about
  end
end
