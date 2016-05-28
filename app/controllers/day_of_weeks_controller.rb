class DayOfWeeksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_id, only: [:index, :show, :create, :update, :destroy]

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      ride = user.driver.rides.find(@ride_id)
      schedules = ride.schedules.find(@schedule_id)
      @days_of_week = schedules.day_of_weeks.all
    else
      @days_of_week = DayOfWeek.all
    end
    render json: @days_of_week
  end

  def show
    user = User.find(params[:user_id])
    ride = user.driver.rides.find(@ride_id)
    schedule = ride.schedules.find(@schedule_id)
    @day_of_week = schedule.day_of_weeks.find(@day_of_week_id)
    render json: @day_of_week
  end

  def create
    user = User.find(params[:user_id])
    ride = user.driver.rides.find(params[:ride_id])
    schedule = ride.schedules.find(params[:schedule_id])
    @day_of_week = schedule.day_of_weeks.new(day_of_week_params)

    if(@day_of_week.save)
      render json: @day_of_week
    else
      render json: @day_of_week.errors
    end
  end

  def update
    if (params[:user_id])
      user = User.find(params[:user_id])
      ride = user.driver.rides.find(@ride_id)
      schedule = ride.schedules.find(@schedule_id)
      @day_of_week = schedule.day_of_weeks.find(@day_of_week_id)
      if(@day_of_week.update_attributes(day_of_week_params))
        render json: @day_of_week
      else
        render json: @day_of_week.errors
      end
    end
  end

  def destroy
    if (params[:user_id])
       user = User.find(params[:user_id])
       ride = user.driver.rides.find(@ride_id)
       schedule = ride.schedules.find(@schedule_id)
       @day_of_week = schedule.day_of_weeks.find(@day_of_week_id)
       if (@day_of_week.destroy)
         render json: @day_of_week
       else
         render json: @day_of_week.errors
       end
    end
  end

  private
  
  def set_id
    @ride_id = params[:ride_id] || params[:id]
    @schedule_id = params[:schedule_id] || params[:id]
    @day_of_week_id = params[:day_of_week_id] || params[:id]
  end

  def day_of_week_params
    params.require(:day_of_week).permit(:value, :day, :departure_time, :return_time)
  end

  def default_serializer_options
    {root: false}
  end
end
