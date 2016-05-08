class RidesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create, :update, :destroy]
  before_action :set_user, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :set_ride, only: [:show, :edit, :update, :destroy]

  def index
    @rides = @user.driver.rides.all
    render json: @rides
  end

  def show
    render json: @ride
  end

  def edit
  end

  def create
    if @user.driver.nil?
      @user.driver = Driver.new
      @ride = @user.driver.rides.new(ride_params)
    else
      @ride = @user.driver.rides.new(ride_params)
    end

    @ride.origin = params["origin"]
    @ride.title = params["title"]
    @ride.departure_time = params["departure_time"]
    @ride.destiny = params["destiny"]

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
    params.require(:ride).permit(:title, :origin, :destiny, :total_seats, :departure_time,
    :return_time, :is_finished, :is_subsistence_allow, :is_subsistence_allowance,
    :is_only_departure, :description, :driver, :vehicle, :passengers_name, :passengers_photo,
    :created_at, :updated_at)
  end

  def vehicle_params
    params.require(:vehicle).permit(:id, :car_model, :color, :driver, :rides)
  end

  def default_serializer_options
    {root: false}
  end
end
