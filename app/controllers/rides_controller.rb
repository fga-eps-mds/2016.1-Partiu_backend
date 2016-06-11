class RidesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_id, only: [:index, :show, :update, :destroy]

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      @rides = user.driver.rides.where(Ride.arel_table[:date].gt(DateTime.now))
    else
      @rides = Ride.where(Ride.arel_table[:date].gt(DateTime.now))
    end
    render json: @rides
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      @ride = user.driver.rides.find(@ride_id)
    else
      @ride = Ride.find(@ride_id)
    end
    render json: @ride
  end

  def create
    user = User.find(params[:user_id])
    @ride = user.driver.rides.new(ride_params)

    if (@ride.save)
      render json: @ride
    else
      render json: @ride.errors
    end
  end

  def update
    if (params[:user_id])
       user = User.find(params[:user_id])
       @ride = user.driver.rides.find(@ride_id)
       if (@ride.update_attributes(ride_params))
         render json: @ride
       else
         render json: @ride.errors
       end
    end
  end

  def destroy
    if (params[:user_id])
       user = User.find(params[:user_id])
       @ride = user.driver.rides.find(@ride_id)
       if (@ride.destroy)
         render json: @ride
       else
         render json: @ride.errors
       end
    end
  end

  private

  def set_id
    @ride_id = params[:ride_id] || params[:id]
  end

  def ride_params
    params.require(:ride).permit(:title, :origin, :destination, :route_distance, 
      :route_time, :date, :total_seats, :departure_time, :return_time, :is_finished, 
      :is_subsistence_allowance, :description, :driver, :vehicle_id)
  end

  def default_serializer_options
    {root: false}
  end

end

