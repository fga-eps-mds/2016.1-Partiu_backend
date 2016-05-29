describe "Vehicles" do

  before do
    @user = FactoryGirl.create(:user)
  end

  describe "user vehicles" do
    it "should return all vehicles of given user" do
      10.times do
        FactoryGirl.create(:vehicle, driver: @user.driver)
      end

      get "/api/users/#{@user.id}/vehicles", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(10)
    end
  end

  describe "rides index" do
    it "should return all vehicles" do
      other_user = FactoryGirl.create(:user, email: "anotheremail@gmail.com")

      5.times do
        FactoryGirl.create(:vehicle, driver: @user.driver)
        FactoryGirl.create(:vehicle, driver: other_user.driver)
      end

      get "/api/vehicles", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(10)
    end
  end

  describe "vehicles#create" do
    it "should create a new vehicle if valid params are given" do
      vehicle = FactoryGirl.attributes_for(:vehicle)
      old_count = Vehicle.count

      get "/api/users/#{@user.id}/vehicles", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      
      expect(body.length).to eq(0)
      
      post "/api/users/#{@user.id}/vehicles", {vehicle: vehicle, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      
      expect(Vehicle.count).to eq(old_count+1)
      
      get "/api/users/#{@user.id}/vehicles", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      
      expect(body.length).to eq(1)
    end

    it "should not create a vehicle if invalid params are given" do
      vehicle = FactoryGirl.attributes_for(:vehicle)
      old_count = Vehicle.count

      get "/api/users/#{@user.id}/vehicles", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      
      expect(body.length).to eq(0)
      
      vehicle["car_model"] = nil
      post "/api/users/#{@user.id}/vehicles", {vehicle: vehicle, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      
      expect(Vehicle.count).to eq(old_count)
      
      get "/api/users/#{@user.id}/vehicles", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      
      expect(body.length).to eq(0)
    end
  end

  describe "vehicles#show" do
    it "should show vehicle of any user" do
      other_user = FactoryGirl.create(:user, email: "anotheremail@gmail.com")

      vehicle1 = FactoryGirl.create(:vehicle, driver: @user.driver)
      vehicle2 = FactoryGirl.create(:vehicle, driver: other_user.driver)

      get "/api/vehicles/#{vehicle1.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)

      get "/api/vehicles/#{vehicle2.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end
  end

  describe "user vehicles#show" do
    it "Should show vehicle of the logged user" do
      other_user = FactoryGirl.create(:user, email: "anotheremail@gmail.com")
      vehicle1 = FactoryGirl.create(:vehicle, driver: @user.driver)
      vehicle2 = FactoryGirl.create(:vehicle, driver: other_user.driver)
      get "/api/users/#{@user.id}/vehicles/#{vehicle1.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      get "/api/users/#{other_user.id}/vehicles/#{vehicle2.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end
  end

  describe "vehicles#update:" do
    it "Should update vehicle of the logged user" do
      vehicle = FactoryGirl.create(:vehicle, driver: @user.driver)

      get "/api/users/#{@user.id}/vehicles/#{vehicle.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["car_model"]).to eq(vehicle.car_model)
      expect(body["color"]).to eq(vehicle.color)

      put "/api/users/#{@user.id}/vehicles/#{vehicle.id}", {vehicle: {car_model: "Fusca", color: "azul"}, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["car_model"]).not_to eq(vehicle.car_model)
      expect(body["color"]).not_to eq(vehicle.color)
    end
    
    it "Should not update vehicle if invalid params were givin" do
      vehicle = FactoryGirl.create(:vehicle, driver: @user.driver)

      get "/api/users/#{@user.id}/vehicles/#{vehicle.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["car_model"]).to eq(vehicle.car_model)
      expect(body["color"]).to eq(vehicle.color)

      put "/api/users/#{@user.id}/vehicles/#{vehicle.id}", {vehicle: {car_model: "", color: "preto"}, driver_id: @user.driver.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      get "/api/users/#{@user.id}/vehicles/#{vehicle.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["car_model"]).to eq(vehicle.car_model)
      expect(body["color"]).to eq(vehicle.color)
    end
  end
  
  describe "vehicles#destroy" do
    it "Should destroy vehicle of the logged user" do
      vehicle1 = FactoryGirl.create(:vehicle, driver: @user.driver)
      FactoryGirl.create(:vehicle, driver: @user.driver)
      FactoryGirl.create(:vehicle, driver: @user.driver)
      
      get "/api/users/#{@user.id}/vehicles", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(3)
      
      delete "/api/users/#{@user.id}/vehicles/#{vehicle1.id}"
      expect(response.status).to eq(200)

      get "/api/users/#{@user.id}/vehicles", {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)
      expect(body.length).to eq(2)
    end
  end
end
