describe "Days_of_week" do
  before do
    @user = FactoryGirl.create(:user)
    @ride = FactoryGirl.create(:ride, driver: @user.driver)
    @schedule = FactoryGirl.create(:schedule, ride: @ride)
  end

  describe "schedule days of week" do
    it "Should return all days of week that the ride will be repeated" do
      FactoryGirl.create(:day_of_week, schedule: @schedule)
      FactoryGirl.create(:day_of_week, schedule: @schedule)
      FactoryGirl.create(:day_of_week, schedule: @schedule)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(3)
    end
  end

  describe "days_of_week#show" do
    it "Should show day of the week that the ride will be repeated" do
      segunda = FactoryGirl.create(:day_of_week, schedule: @schedule)
      quinta = FactoryGirl.create(:day_of_week, schedule: @schedule)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks/#{segunda.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks/#{quinta.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
    end
  end

  describe "days_of_week#create" do
    it "Should create a new day of week that the ride will be repeated with valid params" do
      day_of_week = FactoryGirl.attributes_for(:day_of_week)
      old_count = DayOfWeek.count
      
      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      
      body = JSON.parse(response.body)
      expect(body.length).to eq(0)

      post "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks", {day_of_week: day_of_week, schedule_id: @schedule.id}
      expect(response.status).to eq(200)

      expect(DayOfWeek.count).to eq(old_count+1)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      
      body = JSON.parse(response.body)
      expect(body.length).to eq(1)
    end

    it "should not create a day of week if invalid params are givin" do
      day_of_week = FactoryGirl.attributes_for(:day_of_week)
      old_count = DayOfWeek.count

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks", {}, { "Accept" => "application/json"}
      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body.length).to eq(0)

      day_of_week["value"] = nil
      post "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks", {day_of_week: day_of_week, schedule_id: @schedule.id}
      expect(response.status).to eq(200)

      expect(DayOfWeek.count).to eq(old_count)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)

      expect(body.length).to eq(0)
    end

    it "Should can not be repeated weekdays" do
    end

    it "Should can not have more than 7 days of the scheduled week" do
    end

    it "You can not have no day of the week created with repeat enabled on schedule" do
    end
    
  end

  describe "schedules#update:" do
    it "Should update the day of week of ride schedule" do
      day_of_week = FactoryGirl.create(:day_of_week, schedule: @schedule)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks/#{day_of_week.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["value"]).to eq(day_of_week.value)

      put "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks/#{day_of_week.id}", {day_of_week: {value: 1}, schedule_id: @schedule.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["value"]).not_to eq(day_of_week.value)
    end

    it "Should not update the day_of_week if params are invalid" do
      day_of_week = FactoryGirl.create(:day_of_week, schedule: @schedule)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks/#{day_of_week.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["value"]).to eq(day_of_week.value)

      put "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks/#{day_of_week.id}", {day_of_week: {value: nil}, schedule_id: @schedule.id}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      #expect(body["value"]).to eq(day_of_week.value)
    end

    it "should can not update days of the week with repeated value" do
    end
  end
  
  describe "schedules#destroy" do
    it "Should destroy day of week of ride" do
      day_of_week = FactoryGirl.create(:day_of_week, schedule: @schedule)
      FactoryGirl.create(:day_of_week, schedule: @schedule)
      FactoryGirl.create(:day_of_week, schedule: @schedule)
      
      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(3)
      
      delete "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks/#{day_of_week.id}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)

      get "/api/users/#{@user.id}/rides/#{@ride.id}/schedules/#{@schedule.id}/day_of_weeks", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(2)
    end
  end
end
