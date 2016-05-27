class RidesController < ApplicationController
  skip_before_filter :verify_authenticity_token

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
    if params[:user_id]
      user = User.find(params[:user_id])
      @ride = user.driver.rides.find(ride_id)
    else
      @ride = Ride.find(ride_id)
    end
    render json: @ride
  end 

  def edit
  end

  def create
=begin
  datas = params["datas"]
  ridesCreated = []
  for data in datas
    @ride = Ride.new(ride_params)
    user = User.find(params[:user_id])
    @ride.driver = user.driver
    if (@ride.save)
      ridesCreated.append(@ride)
    end
   end 
   render json: ridesCreated.first
=end
    @user = User.find(params[:user_id])
    @ride = @user.driver.rides.new(ride_params)

    if (@ride.save)
      render json: @ride
    else
      render json: @ride.errors
    end
  end

  def update
    ride_id = params[:ride_id] || params[:id]
    if (params[:user_id])
       user = User.find(params[:user_id])
       @ride = user.driver.rides.find(ride_id)
       if (@ride.update_attributes(ride_params))
         render json: @ride
       else
         render json: @ride.errors
       end
    end
  end

  def destroy
    ride_id = params[:ride_id] || params[:id]
    if (params[:user_id])
       user = User.find(params[:user_id])
       @ride = user.driver.rides.find(ride_id)
       if (@ride.destroy)
         render json: @ride
       else
         render json: @ride.errors
       end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_ride
    @user = User.find(params[:user_id])
    @ride = @user.driver.rides.find(params[:id])
  end

  def ride_params
    params.require(:ride).permit(:title, :origin, :destiny, :route_distance, 
      :route_time, :total_seats, :is_finished, :is_subsistence_allowance, 
      :schedule_ride, :description, :driver, :vehicle, :passengers_name, 
      :passengers_photo)
  end

  def default_serializer_options
    {root: false}
  end
end
