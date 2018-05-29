RSpec.describe "Sessions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { {  HTTP_ACCEPT: 'application/json' } }
  
  context "valid credentials & logout" do
    it "successfully logs in user" do
      post "/api/v1/login", params: {
      	name: user.name, password: user.password 
      }, headers: headers

      expect(response.status).to eq 200
      expect(response_json).to eq "token"=>"#{User.first.auth_token}", "name"=>"#{User.first.name}"
    end

    it "successfully logs out user" do
      delete "/api/v1/logout", headers: headers.merge!("Authorization": "Token #{user.auth_token}")

      expect(response.status).to eq 200
    end
  end

  context "without valid credentials" do
  	it "does not login user if email is incorrect" do
      post "/api/v1/login", params: {
      	email: "ran@gmail.com", password: user.password
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json["errors"][0]["detail"]).to eq "Error with name or password"

  	end

  	it "does not login user if password is incorrect" do
      post "/api/v1/login", params: {
      	email: user.email, password: "rightright"      
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json["errors"][0]["detail"]).to eq "Error with name or password"
  	end
  end
end