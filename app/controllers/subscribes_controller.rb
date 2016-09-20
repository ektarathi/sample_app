class SubscribesController < ApplicationController

  def new
    @subscribe = Subscribe.new
  end

  def create
     @subscribe = Subscribe.new(allowed_params)

    if @subscribe.save
      redirect_to thank_you_path
    else
      render 'new'
    end
  end

  private

  def allowed_params
    params.require(:subscribe).permit(:first_name, :last_name, :email)
  end
end
