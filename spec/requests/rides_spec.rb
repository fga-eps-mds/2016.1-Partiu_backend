describe "Rides" do
  describe "rides#index" do
    it "should return all rides" do
      ride = FactoryGirl.create(:ride)

      get "/api/rides", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body[0]["title"]).to eq(ride.title)
      expect(body[0]["total_seats"]).to eq(ride.total_seats)
      expect(body[0]["origin"]).to eq(ride.origin)
      expect(body[0]["destiny"]).to eq(ride.destiny)
    end
  end

  describe "rides#create" do
    it "should create a new ride if valid ride is given" do
      ride = FactoryGirl.attributes_for(:ride)
      old_count = Ride.all.count
      post "/api/rides", {ride: ride}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      expect(Ride.all.count).to eq(old_count+1)
    end

    it "should not create a new ride if invalid attributes are given" do
      ride = FactoryGirl.attributes_for(:ride)
      ride["title"] = "a"*40
      old_count = Ride.all.count
      post "/api/rides", {ride: ride}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      expect(Ride.all.count).to eq(old_count)
    end
  end
end
