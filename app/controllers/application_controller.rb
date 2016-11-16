require 'mailchimp'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :setup_mcapi

  def setup_mcapi
    @mail_chimp = Mailchimp::API.new('df3d6bae800cf762392a96f517c67005-us13')
  end
end
