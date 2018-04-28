RSpec.describe "User Sessions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { {  HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  context "valid credentials" do
    it "successfully logs in user" do
      post "/api/v1/auth/sign_in", params: {
      	email: user.email, password: user.password      
      }, headers: headers

      expect(response.status).to eq 200
      expected_response = eval(file_fixture('success_login.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end

  context "without valid credentials" do
  	it "does not login user if email is incorrect" do
      post "/api/v1/auth/sign_in", params: {
      	email: "ran@gmail.com", password: user.password
      }, headers: headers

      expect(response.status).to eq 401
      expect(response_json["errors"][0]).to eq "Invalid login credentials. Please try again."
  	end

  	it "does not login user if password is incorrect" do
      post "/api/v1/auth/sign_in", params: {
      	email: user.email, password: "rightright"      
      }, headers: headers

      expect(response.status).to eq 401
      expect(response_json["errors"][0]).to eq "Invalid login credentials. Please try again."
  	end
  end
end