require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
  end

  it { expect(@user).to respond_to(:name, :email, :passenger) }

  it { expect(@user).to be_valid }

  describe "instantiation" do
    it "should create new driver and passenger" do
      attrs = FactoryGirl.attributes_for(:user, email: "antherforbidden@gmail.com")
      user = User.new(attrs)
      user.save
      expect(user).to eq(User.last)
      expect(user.driver).not_to eq(nil)
      expect(user.passenger).not_to eq(nil)
    end
  end
end
