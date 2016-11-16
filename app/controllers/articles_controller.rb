class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_as_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
  	@article = Article.new
    if !logged_in?
      redirect_to login_path, flash: { error: 'Please log in to create new article.'}
    else
      render 'new'
    end
  end

  def edit
  end

  def create
  	@article = Article.new(allowed_params)

  	if @article.save
		  redirect_to root_path, flash: { notice: 'Article was successfully created.' }
  	else
  		render 'new'
  	end
  end

  def update
  	if @article.update_attributes(allowed_params)
      redirect_to root_path, flash: { notice: 'Article was successfully updated.' }
    else
      render 'edit'
    end
  end

  def destroy
  	@article.destroy
  	redirect_to root_path, flash: { notice: 'Article was successfully deleted.' }
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  # Confirms a logged-in user.
  def logged_in_as_user
    unless logged_in?
      redirect_to login_path, flash: { error: 'Please log in to edit the article.'}
    end
  end

  # Confirms the correct user article.
  def correct_user
    @article = Article.find(params[:id])
    redirect_to root_url, flash: { error: 'Article can be edited/viewed by their own user!!'} unless @article.user.id == current_user.id
  end

  def allowed_params
  	params.require(:article).permit(:title, :text, :user_id)
  end
end
