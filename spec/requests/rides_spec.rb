describe "Rides" do

  before do
    @user = FactoryGirl.create(:user)
  end

  describe "user rides" do
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

      get "/api/users/#{@user.id}/rides", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      
      expect(body.length).to eq(0)
      
      post "/api/users/#{@user.id}/rides", {ride: ride, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      
      expect(Ride.count).to eq(old_count+1)
      
      get "/api/users/#{@user.id}/rides", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      
      expect(body.length).to eq(1)
    end

    it "should not create a ride if invalid params are given" do
      ride = FactoryGirl.attributes_for(:ride)
      old_count = Ride.count

      get "/api/users/#{@user.id}/rides", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      
      expect(body.length).to eq(0)
      
      ride["origin"] = nil
      post "/api/users/#{@user.id}/rides", {ride: ride, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      
      expect(Ride.count).to eq(old_count)
      
      get "/api/users/#{@user.id}/rides", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      
      expect(body.length).to eq(0)
    end
  end

  describe "rides#show" do
    it "should show ride of any user" do
      other_user = FactoryGirl.create(:user, email: "anotheremail@gmail.com")

      ride1 = FactoryGirl.create(:ride, driver: @user.driver)
      ride2 = FactoryGirl.create(:ride, driver: other_user.driver)

      get "/api/rides/#{ride1.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)

      get "/api/rides/#{ride2.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end
  end

  describe "user rides#show" do
    it "Should show ride of the logged user" do
      other_user = FactoryGirl.create(:user, email: "anotheremail@gmail.com")
      ride1 = FactoryGirl.create(:ride, driver: @user.driver)
      ride2 = FactoryGirl.create(:ride, driver: other_user.driver)
      get "/api/users/#{@user.id}/rides/#{ride1.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      get "/api/users/#{other_user.id}/rides/#{ride2.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end
  end

  describe "rides#update:" do
    it "Should update ride of the logged user" do
      ride = FactoryGirl.create(:ride, driver: @user.driver)

      get "/api/users/#{@user.id}/rides/#{ride.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["origin"]).to eq(ride.origin)
      expect(body["total_seats"]).to eq(ride.total_seats)

      put "/api/users/#{@user.id}/rides/#{ride.id}", {ride: {origin: "Ceilandia", total_seats: 2}, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["origin"]).not_to eq(ride.origin)
      expect(body["total_seats"]).not_to eq(ride.total_seats)
    end
    
    it "Should not update ride if invalid params were givin" do
      ride = FactoryGirl.create(:ride, driver: @user.driver)

      get "/api/users/#{@user.id}/rides/#{ride.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["title"]).to eq(ride.title)
      expect(body["total_seats"]).to eq(ride.total_seats)

      put "/api/users/#{@user.id}/rides/#{ride.id}", {ride: {title: "", total_seats: 2}, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      #expect(body["title"]).to eq(ride.errors.full_messages)
      #expect(body["total_seats"]).to eq(ride.total_seats)
    end
  end


  describe "rides#destroy" do
    it "Should destroy ride of the logged user" do
      ride1 = FactoryGirl.create(:ride, driver: @user.driver)
      FactoryGirl.create(:ride, driver: @user.driver)
      FactoryGirl.create(:ride, driver: @user.driver)
      
      get "/api/users/#{@user.id}/rides", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(3)
      
      delete "/api/users/#{@user.id}/rides/#{ride1.id}"
      expect(response.status).to eq(200)

      get "/api/users/#{@user.id}/rides", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      expect(body.length).to eq(2)
    end
  end

end
