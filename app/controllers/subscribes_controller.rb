class SubscribesController < ApplicationController

  def new
    @subscribe = Subscribe.new
  end

  def create
    @subscribe = Subscribe.new(allowed_params)

    first_name = allowed_params[:first_name]
    last_name = allowed_params[:last_name]
    email = allowed_params[:email]
    list_name = @mail_chimp.lists.list['data'].first['id']

    if @subscribe.save
      begin
        @mail_chimp.lists.subscribe(list_name, { 'email' => email }, { 'FNAME' => first_name, 'LNAME' => last_name })
        redirect_to thank_you_path, flash: { notice: 'Congratulations, Check your email to confirm sign up!!!' }
      rescue Mailchimp::ListAlreadySubscribedError
        flash.now[:error] = "#{email} is already subscribed to the list"
      rescue Mailchimp::ListDoesNotExistError
        flash.now[:error] = 'The list could not be found.'
      rescue Mailchimp::Error
        flash.now[:error] = 'An unknown error occurred.'
      end
    else
      render 'new'
    end
  end

  private

  def allowed_params
    params.require(:subscribe).permit(:first_name, :last_name, :email)
  end
end
