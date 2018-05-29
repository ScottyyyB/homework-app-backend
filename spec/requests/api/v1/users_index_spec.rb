RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) { FactoryBot.create(:user, student: true) }
  let(:headers) { { HTTP_ACCEPT: 'application/json', "Authorization": "Token #{user.auth_token}" } }

  before do 
    FactoryBot.create(:user, email: 'test@gmail.com', teacher: true, name: 'Murphy Joe', grade: nil)
    FactoryBot.create(:user, email: 'test1@gmail.com', teacher: true, name: 'Jones Bob', grade: nil)
    FactoryBot.create(:user, email: 'test2@gmail.com', grade: 10, name: 'Mist Bob', student: true)
    FactoryBot.create(:user, email: 'test3@gmail.com', grade: 10, name: 'Ale Bob', student: true)
  end
  describe "GET /api/v1/users" do
  	it "should return all users that are students" do
  	  get "/api/v1/users", params: {
  	  	type: "student"
  	  }, headers: headers

  	  expect(response.status).to eq 200
  	  expected_response = eval(file_fixture('users_index_students.txt').read)
  	  expect(response_json).to eq expected_response.as_json
  	end

    it "should return all users that teachers" do
      get "/api/v1/users", params: {
        type: "teacher"
      }, headers: headers

      expect(response.status).to eq 200
      expected_response = eval(file_fixture('users_index_teachers.txt').read)
      expect(response_json).to eq expected_response.as_json
    end

    it "should return all users by specific grade" do
      get "/api/v1/users", params: {
        type: "student", grade: 10
      }, headers: headers

      expect(response.status).to eq 200
      expected_response = eval(file_fixture('users_index_grade_filter.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
    
    it "should return all users" do
      get "/api/v1/users", headers: headers

      expect(response.status).to eq 200
      expected_response = eval(file_fixture('users_index.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end
end