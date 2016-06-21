require 'rails_helper'

RSpec.describe UsersController do

  before do
    @user = FactoryGirl.create(:user, name: "User Tester")
  end

  describe "show" do

    it "must return a specific users" do
      get :show, id: @user.id

      expect(response.body).to include(@user.name)
    end

  end

  describe "create" do

    it "must create a new user" do
      expect {
        post :create, user: {
          name: "New User",
          phone: "(61) 9999-1029",
          email: "new_user@mail.com",
          token: "ASDF89AUDS898CUAS8",
          gender: "Masculino",
          photo_url: "mynewphoto.photo.com",
          facebook_id: "98765",
          link_profile: "new_user@facebook.com"
        }
      }.to change { User.count }.by(1)
    end

    it "must return token if user already exists" do
      post :create, user: FactoryGirl.attributes_for(:user)

      expect(response.body).to include("token")
    end
  end

  describe "get_user_id" do
    it "must return user_id when provided facebook_id of registered user" do
      get :get_user_id, facebook_id: @user.facebook_id

      expect(response.body).to eq("#{@user.id}")
    end

    it "must not return user_id when provided facebook_id that do not match any registered user" do
      get :get_user_id, facebook_id: "999999"

      expect(response.body).not_to eq("#{@user.id}")
    end
  end

end
