class VehiclesController < ApplicationController
  before_action :set_user, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  before_action :login_filter, only: [:index, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  def index
    @vehicles = @user.driver.vehicles.all
    render json: @vehicles
  end

  def show
    render json: @vehicle
  end

  def edit
  end

  def create
    @vehicle = @user.driver.vehicles.new(vehicle_params)

    if (@vehicle.save)
      render json: @vehicle
    else
      render json: @vehicle.errors
    end
  end

  def update
    if (@vehicle.update(vehicle_params))
      render json: @vehicle
    else
      render json: @vehicle.errors
    end
  end

  def destroy
    @vehicle.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_vehicle
    @vehicle = @user.driver.vehicles.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:id, :car_model, :color, :driver, :rides)
  end

  def default_serializer_options
    {root: false}
  end
end
