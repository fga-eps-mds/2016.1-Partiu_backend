describe "Rides" do

  before do
    @user = FactoryGirl.create(:user)
  end

  describe "users rides" do
    it "should return all rides of given user" do
      10.times do
        FactoryGirl.create(:ride, driver: @user.driver)
      end
      get "/api/users/#{@user.id}/rides", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(10)
    end
  end

  describe "rides index" do
    it "should return all rides" do
      other_user = FactoryGirl.create(:user, email: "anotheremail@gmail.com")

      5.times do
        FactoryGirl.create(:ride, driver: @user.driver)
        FactoryGirl.create(:ride, driver: other_user.driver)
      end

      get "/api/rides", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(10)
    end
  end

  describe "rides#create" do
    it "should create a new ride if valid params are given" do
      ride = FactoryGirl.attributes_for(:ride)
      old_count = Ride.count
      get "/api/users/#{@user.id.to_s}/rides", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      expect(body.length).to eq(0)
      post "/api/users/#{@user.id.to_s}/rides", {ride: ride, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      expect(Ride.count).to eq(old_count+1)
      get "/api/users/#{@user.id.to_s}/rides", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      expect(body.length).to eq(1)
    end

    it "should not create a ride if invalid params are given" do
      ride = FactoryGirl.attributes_for(:ride)
      old_count = Ride.count
      get "/api/users/#{@user.id.to_s}/rides", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      expect(body.length).to eq(0)
      ride["origin"] = nil
      post "/api/users/#{@user.id.to_s}/rides", {ride: ride, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      expect(Ride.count).to eq(old_count)
      get "/api/users/#{@user.id.to_s}/rides", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      expect(body.length).to eq(0)

    end
  end

  describe "rides#show" do
    it "should work for a ride already created" do
      ride = FactoryGirl.create(:ride, driver: @user.driver)
      get "/api/rides/#{ride.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end
  end
  
end
