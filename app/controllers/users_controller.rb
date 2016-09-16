class UsersController < ApplicationController

  before_action :load_user, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update]

  def index
  	@users = User.paginate(page: params[:page])
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

  def update
    if @user.update_attributes(allowed_params)
      redirect_to @user, flash: { notice: 'User was successfully updated.' }
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, flash: { notice: 'User was successfully deleted.' }
  end

  private

  def load_user
    @user = User.find_by(id: params[:id])
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def allowed_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

end
