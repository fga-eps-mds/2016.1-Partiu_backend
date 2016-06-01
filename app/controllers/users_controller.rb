class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :login_filter, only: [:index, :edit, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def edit
  end

  def create
    user = User.find_by(facebook_id: user_params[:facebook_id])
    if user
      render json: { token: user.fetch_auth_token! }, status: :ok
    else
      @user = User.new(user_params)
      @user.passenger = Passenger.new
      if (@user.save)
        render json: { token: @user.fetch_auth_token! }, status: :ok
      else
        render json: @user.errors
      end
    end
  end

  def get_user_id
    user = User.find_by(facebook_id: params[:facebook_id])
    if user
      render json: user.id
    else
      render json: User.new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :login, :email, :phone, :gender, :facebook_id,
    :link_profile, :photo_url, :token)
  end

  def default_serializer_options
    {root: false}
  end
end
