RSpec.describe "User Registration", type: :request do
  let(:headers) { { HTTP_ACCEPT: "application/json" } }
  before do
    FactoryBot.create(:user, name: "John Cena")
  end
  
  context "with valid credentials" do
    it "successfully creates a user" do
      post "/api/v1/auth", params: {
        name: "Dan James", email: "hey@gmail.com",
        password: "rightright", password_confirmation: "rightright"
      }, headers: headers

      expect(response_json["status"]).to eq "success"
      expect(response.status).to eq 200
    end
  end

  context "without valid credentials" do
    it "does not create user if name is not present" do
      post "/api/v1/auth", params: {
        email: "hey@gmail.com",
        password: "rightright", password_confirmation: "rightright"
      }, headers: headers

      expect(response_json["errors"]["full_messages"][0]).to eq "Name can't be blank"
      expect(response.status).to eq 422
    end

    it "does not create user if email is not present" do
      post "/api/v1/auth", params: {
        name: "Toby George",
        password: "rightright", password_confirmation: "rightright"
      }, headers: headers

      expect(response_json["errors"]["full_messages"][0]).to eq "Email can't be blank"
      expect(response.status).to eq 422
    end

    it "does not create user if name has been taken" do
      post "/api/v1/auth", params: {
        name: "John Cena", email: "hey@gmail.com",
        password: "rightright", password_confirmation: "rightright"
      }, headers: headers

      expect(response_json["errors"]["full_messages"][0]).to eq "Name has already been taken"
      expect(response.status).to eq 422
    end

    it "does not create user if email has been taken" do
      post "/api/v1/auth", params: {
        name: "Toby George", email: "random@gmail.com",
        password: "rightright", password_confirmation: "rightright"
      }, headers: headers

      expect(response_json["errors"]["full_messages"][0]).to eq "Email has already been taken"
      expect(response.status).to eq 422
    end

    it "does not create user if password_confirmation does not match password" do
      post "/api/v1/auth", params: {
        name: "Toby George", email: "hey@gmail.com",
        password: "rightright", password_confirmation: "doggydoggy"
      }, headers: headers

      expect(response_json["errors"]["full_messages"][0]).to eq "Password confirmation doesn't match Password"
      expect(response.status).to eq 422
    end
  end
end
