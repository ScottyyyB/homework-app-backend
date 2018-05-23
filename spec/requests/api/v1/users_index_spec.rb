RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) { FactoryBot.create(:user, student: true, grade: 10) }
  let(:headers) { { HTTP_ACCEPT: 'application/json', "Authorization": "Token #{user.auth_token}" } }

  before { FactoryBot.create(:user, email: 'test1@gmail.com', teacher: true) }

  describe "GET /api/v1/users" do
  	it "should return all users that are students" do
  	  get "/api/v1/users", params: {
  	  	type: "student"
  	  }, headers: headers

  	  expect(response.status).to eq 200
  	  expected_response = eval(file_fixture('users_index.txt').read)
  	  expect(response_json).to eq expected_response.as_json
  	end
  end
end