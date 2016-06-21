class VehiclesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_id, only: [:index, :show, :update, :destroy]

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      @vehicles = user.driver.vehicles.all
      render json: @vehicles
    end
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      @vehicle = user.driver.vehicles.find(@vehicle_id)
    else
      @vehicle = Vehicle.find(@vehicle_id)
    end
    render json: @vehicle
  end

  def create
    user = User.find(params[:user_id])
    @vehicle = user.driver.vehicles.new(vehicle_params)

    if (@vehicle.save)
      render json: @vehicle
    else
      render json: @vehicle.errors
    end
  end

  def update
    if (params[:user_id])
       user = User.find(params[:user_id])
       @vehicle = user.driver.vehicles.find(@vehicle_id)
       if (@vehicle.update_attributes(vehicle_params))
         render json: @vehicle
       else
         render json: @vehicle.errors
       end
    end
  end

  def destroy
    if (params[:user_id])
       user = User.find(params[:user_id])
       @vehicle = user.driver.vehicles.find(@vehicle_id)
       if (@vehicle.destroy)
         render json: @vehicle
       else
         @vehicle.errors.add(:vehicle, "Cannot delete vehicle")
         render json: @vehicle.errors
       end
    end
  end

  private

  def set_id
    @vehicle_id = params[:vehicle_id] || params[:id]
  end

  def vehicle_params
    params.require(:vehicle).permit(:id, :car_model, :color, :description)
  end

  def default_serializer_options
    {root: false}
  end
end
