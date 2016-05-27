class RidesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_ride, only: [:edit, :update, :destroy]

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      @rides = user.driver.rides.all
    else
      @rides = Ride.all
    end
    render json: @rides
  end

  def show
    ride_id = params[:ride_id] || params[:id]
    @ride = Ride.find(ride_id)
    render json: @ride
  end

  def edit
  end

  def create
    @ride = Ride.new(ride_params)
    user = User.find(params[:user_id])
    @ride.driver = user.driver

    if (@ride.save)
      render json: @ride
    else
      render json: @ride.errors
    end
  end

  def update
    if (@ride.update(ride_params))
      render json: @ride
    else
      render json: @ride.errors
    end
  end

  def destroy
    @ride.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_ride
    @ride = @user.driver.rides.find(params[:id])
  end

  def ride_params
    params.require(:ride).permit(:title, :origin, :destination, :total_seats, :departure_time,
    :return_time, :is_finished, :is_subsistence_allow, :is_subsistence_allowance,
    :is_only_departure, :description, :vehicle, :passengers_name, :passengers_photo,
    :created_at, :driver_id, :updated_at)
  end

  def vehicle_params
    params.require(:vehicle).permit(:id, :car_model, :color, :driver, :rides)
  end

  def default_serializer_options
    {root: false}
  end
end
