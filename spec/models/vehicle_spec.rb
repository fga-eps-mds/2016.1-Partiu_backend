require 'rails_helper'

RSpec.describe Vehicle, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @vehicle = FactoryGirl.create(:vehicle, driver: @user.driver)
  end

  it { expect(@vehicle).to respond_to(:color, :car_model, :driver_id) }

  it { expect(@vehicle).to be_valid }

  describe "if its driver is destroyed" do
    it "must be also destroyed" do
      expect(@user).to be_valid
      expect(@vehicle).to be_valid
      vehicle_count = Vehicle.all.count
      @user.destroy
      expect(Vehicle.all.count).to eq(vehicle_count-1)
    end
  end

  describe "attributes" do

    subject { FactoryGirl.attributes_for(:vehicle, driver: @user.driver) }

    describe "driver_id" do

      it "must be given" do
        vehicle = Vehicle.new(subject)
        vehicle.driver = nil
        expect(vehicle).not_to be_valid
        vehicle.driver = @user.driver
        expect(vehicle).to be_valid
      end
    end

    describe "color" do

      it "must be given" do
        subject["color"] = nil
        expect(Vehicle.new(subject)).not_to be_valid
        subject["color"] = "blue"
        expect(Vehicle.new(subject)).to be_valid
      end

      it "cant be longer than 20 chars" do
        subject["color"] = "a"*21
        expect(Vehicle.new(subject)).not_to be_valid
        subject["color"] = "a"*20
        expect(Vehicle.new(subject)).to be_valid
      end

      it "must be at least 2 chars" do
        subject["color"] = "a"*1
        expect(Vehicle.new(subject)).not_to be_valid
        subject["color"] = "a"*2
        expect(Vehicle.new(subject)).to be_valid
      end
    end

    describe "car_model" do

      it "must be given" do
        subject["car_model"] = nil
        expect(Vehicle.new(subject)).not_to be_valid
        subject["car_model"] = "Another nice car"
        expect(Vehicle.new(subject)).to be_valid
      end

      it "must be at least 2 chars" do
        subject["car_model"] = "a"
        expect(Vehicle.new(subject)).not_to be_valid
        subject["car_model"] = "a"*2
        expect(Vehicle.new(subject)).to be_valid
      end

      it "cant be longer than 20 chars" do
        subject["car_model"] = "a"*21
        expect(Vehicle.new(subject)).not_to be_valid
        subject["car_model"] = "a"*20
        expect(Vehicle.new(subject)).to be_valid
      end

    end
  end
end
