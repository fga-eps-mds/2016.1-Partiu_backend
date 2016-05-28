describe "Schedules" do

  before do
    @user = FactoryGirl.create(:user)
    @ride = FactoryGirl.create(:ride, driver: @user.driver)
  end

  describe "user ride schedules" do
    it "Should return all schedules of given ride from user" do
      10.times do
        FactoryGirl.create(:schedule, ride: @ride)
      end

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(10)
    end
  end

  describe "schedules#index" do
    it "Should return all schedules" do
      other_user = FactoryGirl.create(:user, email: "anotheremail@gmail.com")
      other_ride = FactoryGirl.create(:ride, driver: other_user.driver)

      5.times do
        FactoryGirl.create(:schedule, ride: @ride)
        FactoryGirl.create(:schedule, ride: other_ride)
      end

      get "/api/schedules", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(10)
    end
  end

  describe "schendule#create" do
    it "Should create a new schedule of ride if valid params are given" do
      schedule = FactoryGirl.attributes_for(:schedule)
      old_count = Schedule.count
      
      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      
      body = JSON.parse(response.body)
      expect(body.length).to eq(0)

      post "/api/users/#{@user.id}/rides/#{@ride.id}/schedules", {schedule: schedule, ride_id: @ride.id}
      expect(response.status).to eq(200)

      expect(Schedule.count).to eq(old_count+1)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      
      body = JSON.parse(response.body)
      expect(body.length).to eq(1)
    end

    it "should not create a schedule if invalid params are givin" do
      schedule = FactoryGirl.attributes_for(:schedule)
      old_count = Schedule.count

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules", {}, { "Accept" => "application/json"}
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body.length).to eq(0)

      schedule["date"] = ""
      post "/api/users/#{@user.id}/rides/#{@ride.id}/schedules", {schedule: schedule, ride_id: @ride.id}
      expect(response.status).to eq(200)

      expect(Schedule.count).to eq(old_count)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)

      expect(body.length).to eq(0)
    end
  end

  describe "schedules#show" do
    it "Should show schedule of ride from users" do
      other_user = FactoryGirl.create(:user, email: "anotheremail@gmail.com")
      other_ride = FactoryGirl.create(:ride, driver: other_user.driver)
      schedule1 = FactoryGirl.create(:schedule, ride: @ride)
      schedule2 = FactoryGirl.create(:schedule, ride: other_ride)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{schedule1.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)

      get "/api/users/#{other_user.id}/rides/#{other_ride.id}/schedules/#{schedule2.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end

    it "Should show schedule of all users" do
      other_user = FactoryGirl.create(:user, email: "anotheremail@gmail.com")
      other_ride = FactoryGirl.create(:ride, driver: other_user.driver)
      schedule1 = FactoryGirl.create(:schedule, ride: @ride)
      schedule2 = FactoryGirl.create(:schedule, ride: other_ride)

      get "/api/schedules/#{schedule1.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)

      get "/api/schedules/#{schedule2.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end
  end

  describe "schedules#update:" do
    it "Should update schedule of the logged user" do
      schedule = FactoryGirl.create(:schedule, ride: @ride)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{schedule.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["repeat"]).to eq(schedule.repeat)

      put "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{schedule.id}", {schedule: {repeat: true}, ride_id: @ride.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["repeat"]).not_to eq(schedule.repeat)

    end
    
    it "Should not update schedule if params are invalid" do
      schedule = FactoryGirl.create(:schedule, ride: @ride)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{schedule.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["repeat"]).to eq(schedule.repeat)

      put "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{schedule.id}", {schedule: {repeat: nil}, ride_id: @ride.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      #expect(body["repeat"]).to eq(schedule.repeat)
    end
  end

  describe "schedules#destroy" do
    it "Should destroy schedule of the logged user" do
      schedule = FactoryGirl.create(:schedule, ride: @ride)
      FactoryGirl.create(:schedule, ride: @ride)
      FactoryGirl.create(:schedule, ride: @ride)
      
      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(3)
      
      delete "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{schedule.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(2)
    end
  end
end
