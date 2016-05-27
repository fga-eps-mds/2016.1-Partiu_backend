describe "Users" do
  describe "users#index" do
    it "should return all users" do
      user =  FactoryGirl.create(:user)

      get "/api/users", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body[0]["name"]).to eq(user.name)
      expect(body[0]["id"]).to eq(user.id)
      expect(body[0]["facebook_id"]).to eq(user.facebook_id)
      expect(body[0]["email"]).to eq(user.email)
      expect(body[0]["phone"]).to eq(user.phone)
      expect(body[0]["gender"]).to eq(user.gender)
      expect(body[0]["photo_url"]).to eq(user.photo_url)
    end
  end

  describe "users#create" do
    it "should create a new user if valid user is given" do
      user = FactoryGirl.attributes_for(:user)
      old_count = User.all.count
      post "/api/users", {user: user}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      expect(User.all.count).to eq(old_count+1)
    end

    it "should not create a new user if invalid attributes are given" do
      user = FactoryGirl.attributes_for(:user)
      user["email"] = ""
      old_count = User.all.count
      post "/api/users", {user: user}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      expect(User.all.count).to eq(old_count)
    end

    it "should create a driver and a passenger" do
      user = FactoryGirl.attributes_for(:user)
      post "/api/users", {user: user}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      json_response = JSON.parse(response.body)
      id = json_response["id"]
      find_user = User.find(id)
      expect(User.find(find_user.id).driver).to be_valid
      expect(User.find(find_user.id).passenger).to be_valid
    end

    it "should find user by facebook_id" do
      user1 =  FactoryGirl.create(:user)
      FactoryGirl.create(:user, email: "usertest@test.com")
      user1["id"] = 5
      
      get "/api/users", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(2)
      expect(body[0]["facebook_id"]).to eq(user1.facebook_id)
      
      user_facebook = User.where(facebook_id: user1.facebook_id)
      expect(user_facebook.empty?).to eq(false)
      expect(user_facebook.first.id).to eq(1)
     end
  end
end
