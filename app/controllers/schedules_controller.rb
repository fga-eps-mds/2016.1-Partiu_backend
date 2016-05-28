class SchedulesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    ride_id = params[:ride_id] || params[:id]
    if params[:user_id]
      user = User.find(params[:user_id])
      ride = user.driver.rides.find(ride_id)
      @schedules = ride.schedules.all
    else
      @schedules = Schedule.all
    end
    render json: @schedules
  end

  def show
    ride_id = params[:ride_id] || params[:id]
    schedule_id = params[:schedule_id] || params[:id]
    if params[:user_id]
      user = User.find(params[:user_id])
      ride = user.driver.rides.find(ride_id)
      @schedule = ride.schedules.find(schedule_id)
    else
      @schedule = Schedule.find(schedule_id)
    end
    render json: @schedule
  end

  def create
    user = User.find(params[:user_id])
    ride = user.driver.rides.find(params[:ride_id])
    @schedule = ride.schedules.new(schedule_params)

    if(@schedule.save)
      render json: @schedule
    else
      render json: @schedule.errors
    end
  end

  def update
    ride_id = params[:ride_id] || params[:id]
    schedule_id = params[:schedule_id] || params[:id]
    if (params[:user_id])
      user = User.find(params[:user_id])
      ride = user.driver.rides.find(ride_id)
      @schedule = ride.schedules.find(schedule_id)
      if(@schedule.update_attributes(schedule_params))
        render json: @schedule
      else
        render json: @schedule.errors
      end
    end
  end

  def destroy
    ride_id = params[:ride_id] || params[:id]
    schedule_id = params[:schedule_id] || params[:id]
    if (params[:user_id])
       user = User.find(params[:user_id])
       ride = user.driver.rides.find(ride_id)
       @schedule = ride.schedules.find(schedule_id)
       if (@schedule.destroy)
         render json: @schedule
       else
         render json: @schedule.errors
       end
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:date, :date_limit, :departure_time, :return_time, :repeat, :ride, :created_at, :updated_at)
  end

  def default_serializer_options
    {root: false}
  end
end
