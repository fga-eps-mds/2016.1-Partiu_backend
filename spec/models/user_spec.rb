require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
  end

  it { expect(@user).to respond_to(:name, :email, :passenger, :driver) }

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

  describe "attribute" do

    subject { FactoryGirl.attributes_for(:user, email: "anotherotheremail@gmail.com") }

    describe "email" do
      it "must be given" do
        subject["email"] = ""
        expect(User.new(subject)).not_to be_valid
      end

      it "must be in valid email format" do
        subject["email"] = "hi1234"
        expect(User.new(subject)).not_to be_valid
        subject["email"] = "hi1234@hi.com"
        expect(User.new(subject)).to be_valid
      end
    end

    describe "name" do
      it "must be given" do
        subject["name"] = ""
        expect(User.new(subject)).not_to be_valid
        subject["name"] = "Hioo123"
        expect(User.new(subject)).to be_valid
      end
    end

    describe "facebook_id" do
      it "must be given" do
        subject["facebook_id"] = nil
        expect(User.new(subject)).not_to be_valid
        subject["facebook_id"] = 5
        expect(User.new(subject)).to be_valid
      end
    end

    describe "photo_url" do
      it "isnt required" do
        subject["photo_url"] = nil
        expect(User.new(subject)).not_to be_valid
        subject["photo_url"] = "www.myphoto.com/myphoto.png"
        expect(User.new(subject)).to be_valid
      end
    end
  end
end
