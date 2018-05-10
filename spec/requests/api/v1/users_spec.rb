
RSpec.describe Api::V1::UsersController, type: :request do
  let(:headers) { { HTTP_ACCEPT: "application/json" } }
  before do
    FactoryBot.create(:user, username: "John Cena")
  end
  
  context "with valid credentials" do
    it "successfully creates a user" do
      post "/api/v1/users", params: {
        user: {
          username: "Dan James", email: "hey@gmail.com",
          password: "rightright"
        }
      }, headers: headers

      expect(response.status).to eq 200
      expect(response_json).to eq "token"=>"#{User.second.auth_token}", "username"=>"#{User.second.username}"
    end
  end

  context "without valid credentials" do
    it "does not create user if username is not present" do
      post "/api/v1/users", params: {
        user: {
          email: "hey@gmail.com",
          password: "rightright"
        }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Username can't be blank"
      expect(response.status).to eq 422
    end

    it "does not create user if email is invalid" do
      post "/api/v1/users", params: {
        user: {
          username: "Toby George",
          password: "rightright"
        }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Email is invalid"
      expect(response.status).to eq 422
    end

    it "does not create user if username has been taken" do
      post "/api/v1/users", params: {
        user: {
          username: "John Cena", email: "hey@gmail.com",
          password: "rightright"
        }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Username has already been taken"
      expect(response.status).to eq 422
    end

    it "does not create user if email has been taken" do
      post "/api/v1/users", params: {
        user: {
          username: "Toby George", email: "random@gmail.com",
          password: "rightright"
        }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Email has already been taken"
      expect(response.status).to eq 422
    end

    it "does not create user if password is not present" do
      post "/api/v1/users", params: {
        user: {
         username: "Toby George", email: "hey@gmail.com"
       }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Password can't be blank"
      expect(response.status).to eq 422
    end
  end
end
