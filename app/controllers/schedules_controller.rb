class SchedulesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_id, only: [:index, :show, :update, :destroy]

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      ride = user.driver.rides.find(@ride_id)
      @schedules = ride.schedules.all
    else
      @schedules = Schedule.all
    end
    render json: @schedules
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      ride = user.driver.rides.find(@ride_id)
      @schedule = ride.schedules.find(@schedule_id)
    else
      @schedule = Schedule.find(@schedule_id)
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
    if (params[:user_id])
      user = User.find(params[:user_id])
      ride = user.driver.rides.find(@ride_id)
      @schedule = ride.schedules.find(@schedule_id)
      if(@schedule.update_attributes(schedule_params))
        render json: @schedule
      else
        render json: @schedule.errors
      end
    end
  end

  def destroy
    if (params[:user_id])
       user = User.find(params[:user_id])
       ride = user.driver.rides.find(@ride_id)
       @schedule = ride.schedules.find(@schedule_id)
       if (@schedule.destroy)
         render json: @schedule
       else
         render json: @schedule.errors
       end
    end
  end

  private

  def set_id
    @ride_id = params[:ride_id] || params[:id]
    @schedule_id = params[:schedule_id] || params[:id]
  end

  def schedule_params
    params.require(:schedule).permit(:date, :date_limit, :departure_time, :return_time, :repeat, :ride, :created_at, :updated_at)
  end

  def default_serializer_options
    {root: false}
  end
end
