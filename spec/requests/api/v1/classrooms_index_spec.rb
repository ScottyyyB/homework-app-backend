RSpec.describe Api::V1::ClassroomsController, type: :request do
  let(:user) { FactoryBot.create(:user, teacher: true) }
  let(:headers1) { { HTTP_ACCEPT: 'application/json', "Authorization": "Token #{user.auth_token}" } }
  let(:headers2) { { HTTP_ACCEPT: 'application/json', "Authorization": "Token #{User.first.auth_token}" } }
  let(:headers_sad) { { HTTP_ACCEPT: 'application/json' } }

  before do
  	FactoryBot.create(:user, email: 'hey@gmail.com', student: true)
  	FactoryBot.create(:classroom, teacher_id: user.id, user_ids: [User.first.id])
  end

  describe "GET /api/v1/classrooms" do
    it "should return all classes for a user that is a teacher" do
      get "/api/v1/classrooms", headers: headers1
      
      expected_response = eval(file_fixture('user_classroom_index.txt').read)
      expect(response_json).to eq expected_response.as_json
    end

    it "should return all classes for a user that is a student" do
      get "/api/v1/classrooms", headers: headers2
      
      expected_response = eval(file_fixture('user_classroom_index.txt').read)
      expect(response_json).to eq expected_response.as_json
    end

    it "should not return classes if user is not signed in" do
      get "/api/v1/classrooms", headers: headers_sad

      expect(response_json["errors"][0]["detail"]).to eq "You need to sign in or sign up before continuing."
	  end
  end

  describe "GET /api/v1/classrooms/:id" do
    it "should return a specific classroom for a user" do
      get "/api/v1/classrooms/#{Classroom.first.id}", headers: headers1

      expected_response = eval(file_fixture('user_classroom_show.txt').read)
      expect(response_json).to eq expected_response.as_json
    end

    it "should not return classes if user is not signed in" do
      get "/api/v1/classrooms/#{Classroom.first.id}", headers: headers_sad

      expect(response_json["errors"][0]["detail"]).to eq "You need to sign in or sign up before continuing."
    end
  end 
end