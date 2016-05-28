class VehiclesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      @vehicles = user.driver.vehicles.all
    else
      @vehicles = Vehicle.all
    end
    render json: @vehicles
  end

  def show
    vehicle_id = params[:vehicle_id] || params[:id]
    @vehicle = Vehicle.find(vehicle_id)
    render json: @vehicle
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

  def vehicle_params
    params.require(:vehicle).permit(:id, :car_model, :color, :driver, :rides)
  end

  def default_serializer_options
    {root: false}
  end
end
