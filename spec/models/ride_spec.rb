require 'rails_helper'

RSpec.describe Ride, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @ride = FactoryGirl.create(:ride, driver: @user.driver)
    @other_ride_attrs = FactoryGirl.attributes_for(:ride, driver: @user.driver)
  end

  it { expect(@ride).to respond_to(:description, :title, :origin, :total_seats, :is_finished, :is_subsistence_allowance, :is_only_departure, :driver_id, :vehicle_id) }

  describe "attributes:" do

    subject { @other_ride_attrs }

    describe "driver_id" do
      it "must be given" do
        subject["driver_id"] = nil
        expect(Ride.new(subject)).not_to be_valid
      end
    end

    describe "title" do

      subject { @other_ride_attrs }

      it "must be given" do
        subject["title"] = ""
        expect(Ride.new(subject)).not_to be_valid
        subject["title"] = "h"*4
        expect(Ride.new(subject)).to be_valid
      end

      it "cant be longer than 20chars" do
        subject["title"] = "a"*21
        expect(Ride.new(subject)).not_to be_valid
        subject["title"] = "a"*20
        expect(Ride.new(subject)).to be_valid
      end

      it "must be longer than 2 chars" do
        subject["title"] = "a"*2
        expect(Ride.new(subject)).not_to be_valid
        subject["title"] = "a"*3
        expect(Ride.new(subject)).to be_valid
      end
    end

    describe "description" do

      subject { @other_ride_attrs }

      it "isnt required" do
        subject["description"] = ""
        expect(Ride.new(subject)).to be_valid
      end

      it "cant be longer than 300 chars" do
        subject["description"] = "a"*301
        expect(Ride.new(subject)).not_to be_valid
        subject["description"] = "a"*300
        expect(Ride.new(subject)).to be_valid
      end
    end

    describe "total_seats" do

      subject { @other_ride_attrs }

      it "must be given" do
        subject["total_seats"] = nil
        expect(Ride.new(subject)).not_to be_valid
      end

      it "must be higher than 0" do
        subject["total_seats"] = 0
        expect(Ride.new(subject)).not_to be_valid
        subject["total_seats"] = 5
        expect(Ride.new(subject)).to be_valid
      end

      it "must be lower than 9" do
        subject["total_seats"] = 9
        expect(Ride.new(subject)).not_to be_valid
        subject["total_seats"] = 8
        expect(Ride.new(subject)).to be_valid
      end

    end

    describe "origin" do

      subject { @other_ride_attrs }

      it "must be given" do
        subject["origin"] = nil
        expect(Ride.new(subject)).not_to be_valid
        subject["origin"] = "Gamão"
        expect(Ride.new(subject)).to be_valid
      end
    end

    describe "destination" do

      subject { @other_ride_attrs }

      it "must be given" do
        subject["destination"] = nil
        expect(Ride.new(subject)).not_to be_valid
        subject["destination"] = "Gama"
        expect(Ride.new(subject)).to be_valid
      end
    end

    describe "departure_time" do

      subject { @other_ride_attrs }

      it "must be given" do
        subject["departure_time"] = nil
        expect(Ride.new(subject)).not_to be_valid
        subject["departure_time"] = "08:00 AM"
        expect(Ride.new(subject)).to be_valid
      end

    end

    describe "return_time" do

      subject { @other_ride_attrs }

      it "isnt required" do
        subject["return_time"] = nil
        expect(Ride.new(subject)).to be_valid
        subject["return_time"] = "10:00 AM"
        expect(Ride.new(subject)).to be_valid
      end

    end
  end

end
