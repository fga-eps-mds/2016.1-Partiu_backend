describe "Users" do
  describe "users#index" do
    it "should return all users" do
      user = FactoryGirl.create(:user)

      get "/api/users", {}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      name = body[0]["name"]

      expect(body[0]["name"]).to eq(user.name)
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

    it "should not crease a new user if invalid attributes are given" do
      user = FactoryGirl.attributes_for(:user)
      user["email"] = ""
      old_count = User.all.count
      post "/api/users", {user: user}, { "Accept" => "application/json" }
      expect(response.status).to eq(200)
      expect(User.all.count).to eq(old_count)
    end
  end
end
