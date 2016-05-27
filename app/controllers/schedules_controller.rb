class SchedulesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_user, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :set_ride, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @schedules = @ride.schedules.all
    render json: @schedules
  end

  def show
    render json: @schedule
  end

  def edit
  end

  def create
    @schedule = @ride.schedules.new(schedule_params)

    if(@schedule.save)
      render json: @schedule
    else
      render json: @schedule.errors
    end
  end

  def update
    if(@schedule.update(schedule_params))
      render json: @schedule
    else
      render json: @schedule.erros
    end
  end

  def destroy
    @schedule.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_ride
    @ride = @user.driver.rides.find(params[:ride_id])
  end

  def set_schedule
    @schedule = @ride.schedules.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:date, :date_limit, :departure_time, :return_time, :repeat, :ride, :created_at, :updated_at)
  end

  def default_serializer_options
    {root: false}
  end
end
