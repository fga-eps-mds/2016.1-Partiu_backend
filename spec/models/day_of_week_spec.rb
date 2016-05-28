require 'rails_helper'

RSpec.describe DayOfWeek, type: :model do
  before do
    @user = FactoryGirl.create(:user)
    @ride = FactoryGirl.create(:ride, driver: @user.driver)
    @schedule = FactoryGirl.create(:schedule, ride: @ride)
    @day_of_week = FactoryGirl.create(:day_of_week, schedule: @schedule)
  end

  it { expect(@day_of_week).to respond_to(:id, :value, :day, :departure_time, :return_time, :schedule) }

  describe "attributes:" do

    describe "value" do
      subject { FactoryGirl.attributes_for(:day_of_week) }
      it "value must be given" do
        subject["value"] = nil
        expect(DayOfWeek.new(subject)).not_to be_valid
        subject["value"] = 1
        expect(DayOfWeek.new(subject)).to be_valid
      end
      it "value must be numericality from 0 to 6" do
        subject["value"] = 7
        expect(DayOfWeek.new(subject)).not_to be_valid
        subject["value"] = 1
        expect(DayOfWeek.new(subject)).to be_valid
      end
    end
    
    describe "day" do
      subject { FactoryGirl.attributes_for(:day_of_week) }
      it "day must be given" do
        subject["day"] = ""
        expect(DayOfWeek.new(subject)).not_to be_valid
        subject["day"] = "Quarta"
        expect(DayOfWeek.new(subject)).to be_valid
      end
    end

    describe "daparture_time" do
      subject { FactoryGirl.attributes_for(:day_of_week) }
      it "departure_time must be given" do
        subject["departure_time"] = ""
        expect(DayOfWeek.new(subject)).not_to be_valid
        subject["departure_time"] = "11:22"
        expect(DayOfWeek.new(subject)).to be_valid
      end
    end
  end
end
