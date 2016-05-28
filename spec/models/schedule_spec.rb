require 'rails_helper'

RSpec.describe Schedule, type: :model do
  before do
    @user = FactoryGirl.create(:user)
    @ride = FactoryGirl.create(:ride, driver: @user.driver)
    @schedule = FactoryGirl.create(:schedule)
  end

  it { expect(@schedule).to respond_to(:id, :date, :date_limit, :departure_time, :return_time, :repeat, :ride) }

  describe "attributes:" do

    describe "date" do
      subject { FactoryGirl.attributes_for(:schedule) }
      it "date must be given" do
        subject["date"] = nil
        expect(Schedule.new(subject)).not_to be_valid
        subject["date"] = "21/08/2016"
        expect(Schedule.new(subject)).to be_valid
      end
    end

    describe "date_limit" do
      subject { FactoryGirl.attributes_for(:schedule) }
      it "date_limit must be given" do
        subject["date_limit"] = nil
        expect(Schedule.new(subject)).not_to be_valid
        subject["date_limit"] = "22/08/2016"
        expect(Schedule.new(subject)).to be_valid
      end
    end

    describe "repeat" do
      subject { FactoryGirl.attributes_for(:schedule) }
      it "repeat must be given" do
        subject["repeat"] = nil
        expect(Schedule.new(subject)).not_to be_valid
        subject["repeat"] = true
        expect(Schedule.new(subject)).to be_valid
      end
    end

  end
end
