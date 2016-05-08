class RidesController < ApplicationController
  def index
    @rides = Ride.all
    render json: @rides
  end

  def show
    @ride = Ride.find(params[:id])
    render json: @ride
  end

  def default_serializer_options
    {root: false}
  end
end
