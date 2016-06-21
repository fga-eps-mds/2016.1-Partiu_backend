require 'rails_helper'

RSpec.describe VehiclesController do
  before do
    allow_any_instance_of(ApplicationController).to receive(:login_filter).and_return(true)

    @user = FactoryGirl.create(:user)
    @vehicle = FactoryGirl.create(:vehicle, driver: @user.driver, description: "A new description to the test")
  end

  describe "index" do
    it "must return all vehicles of a specific user" do
      get :index, user_id: @user.id

      expect(response.body).to include(@vehicle.description)
    end
  end

  describe "show" do
    it "must return a specific vehicle" do
      get :show, id: @vehicle.id

      expect(response.body).to include(@vehicle.description)
    end
  end

  describe "destroy" do
    it "must destroy a specific vehicle" do
      delete :destroy, user_id: @user.id, id: @vehicle.id

      expect(response.body).to include(@vehicle.description)
    end

    it "must render error if cannot destroy a vehicle" do
      allow_any_instance_of(Vehicle).to receive(:destroy).and_return(false)

      delete :destroy, user_id: @user.id, id: @vehicle.id

      expect(response.body).to include("Cannot delete vehicle")
    end
  end

end
