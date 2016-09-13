class UsersController < ApplicationController

  before_action :load_user, only: [:edit, :update, :show]

  def index
  	@users = User.all
  end

  def show
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(allowed_params)

    if @user.save
      log_in @user
      flash[:message] = 'You have successfully registered !!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  private

  def load_user
    @user = User.find_by(id: params[:id])
  end

  def allowed_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

end
