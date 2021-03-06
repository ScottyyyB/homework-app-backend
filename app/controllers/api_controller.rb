class ApiController < ApplicationController
  before_action :current_user
  
  def require_login
  	authenticate_token || render_unauthorized("You need to sign in or sign up before continuing.")
  end

  def current_user
    @current_user ||= authenticate_token
  end

  protected

  def render_unauthorized(message)
    errors = { errors: [ detail: message ] }
    render json: errors, status: 422
  end

  def authenticate_token
  	authenticate_with_http_token do |token, options|
      User.find_by(auth_token: token)
  	end
  end  
end
