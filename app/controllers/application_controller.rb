class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def forbidden
  	render json: {request: 'forbidden'}, status: :unauthorized
  end

  private

  def login_filter
    if User.find_by_auth_token request.headers['HTTP_AUTHORIZATION']
    else
      redirect_to forbidden_path
    end
  end
end
