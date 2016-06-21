require 'rails_helper'

RSpec.describe RidesController do
  before do
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

  describe "show" do
    it "must return a specific ride" do
      get :show, id: @ride.id

      expect(response.body).to include(@ride.title)
    end
  end

end
