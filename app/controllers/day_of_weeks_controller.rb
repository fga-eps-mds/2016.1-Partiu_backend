class DayOfWeeksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_user, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :set_ride, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :set_schedule, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :set_day, only: [:show, :edit, :update, :destroy]

  def index
    @days = @schedule.day_of_weeks.all
    render json: @days
  end

  def show
    render json: @day
  end

  def edit
  end

  def create
    @day = @schedules.day_of_weeks.new(day_params)

    if(@day.save)
      render json: @day
    else
      render json: @day.errors
    end
  end

  def update
    if(@day.update(day_params))
      render json: @day
    else
      render json: @day.erros
    end
  end

  def destroy
    @day.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_ride
    @ride = @user.driver.rides.find(params[:ride_id])
  end

  def set_schedule
    @schedule = @ride.schedules.find(params[:schedule_id])
  end

  def set_day
    @day = @schedule.day_of_weeks.find(params[:id])
  end

  def day_params
    params.require(:day_of_week).permit(:day, :checked, :value, :departure_time, :return_time)
  end

  def default_serializer_options
    {root: false}
  end
end
