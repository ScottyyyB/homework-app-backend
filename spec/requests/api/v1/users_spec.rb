
RSpec.describe Api::V1::UsersController, type: :request do
  let(:headers) { { HTTP_ACCEPT: "application/json" } }
  before do
    FactoryBot.create(:user, name: "John Cena")
  end
  
  context "with valid credentials" do
    it "successfully creates a user" do
      post "/api/v1/users", params: {
        user: {
          name: "Dan James", email: "hey@gmail.com",
          password: "rightright"
        }
      }, headers: headers

      expect(response.status).to eq 200
      expect(response_json).to eq "token"=>"#{User.second.auth_token}", "name"=>"#{User.second.name}"
    end
  end

  context "without valid credentials" do
    it "does not create user if name is not present" do
      post "/api/v1/users", params: {
        user: {
          email: "hey@gmail.com",
          password: "rightright"
        }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Name can't be blank"
      expect(response.status).to eq 422
    end

    it "does not create user if email is invalid" do
      post "/api/v1/users", params: {
        user: {
          name: "Toby George",
          password: "rightright"
        }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Email is invalid"
      expect(response.status).to eq 422
    end

    it "does not create user if name has been taken" do
      post "/api/v1/users", params: {
        user: {
          name: "John Cena", email: "hey@gmail.com",
          password: "rightright"
        }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Name has already been taken"
      expect(response.status).to eq 422
    end

    it "does not create user if email has been taken" do
      post "/api/v1/users", params: {
        user: {
          name: "Toby George", email: "random@gmail.com",
          password: "rightright"
        }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Email has already been taken"
      expect(response.status).to eq 422
    end

    it "does not create user if password is not present" do
      post "/api/v1/users", params: {
        user: {
         name: "Toby George", email: "hey@gmail.com"
       }
      }, headers: headers

      expect(response_json["errors"][0]).to eq "Password can't be blank"
      expect(response.status).to eq 422
    end
  end
end
