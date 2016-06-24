require 'rails_helper'

RSpec.describe RidesController do
  before do
    allow_any_instance_of(ApplicationController).to receive(:login_filter).and_return(true)
    @user = FactoryGirl.create(:user)
    @ride = FactoryGirl.create(:ride, driver: @user.driver)
    @other_ride_attrs = FactoryGirl.attributes_for(:ride, driver: @user.driver)
  end

  describe "passengers" do
    it "must add passenger to ride" do
      another_user = FactoryGirl.create(:user,
        name: "New Passenger", facebook_id: "98765", email: "passenger@mail.com")

      expect(@ride.passengers).to be_empty
      post :insert_passenger, ride_id: @ride.id, passenger_id: another_user.id
      expect(@ride.passengers).to_not be_empty
    end
  end

  describe "index" do
    it "must return all rides of a specific user" do

      get :index, user_id: @user.id

      expect(response.body).to include("#{@ride.id}")
    end
  end

  describe "show" do
    it "must return a specific ride" do
      another_ride = FactoryGirl.create(:ride, driver: @user.driver, title: "Another ride")
      get :show, id: @ride.id

      expect(response.body).not_to include(another_ride.title)
      expect(response.body).to include(@ride.title)
    end
  end

end
