require 'mailchimp'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :setup_mcapi

  def setup_mcapi
    @mail_chimp = Mailchimp::API.new('16bf11d4c6a9a81fb1c6ed8b7fd9b059-us14')
  end
end
