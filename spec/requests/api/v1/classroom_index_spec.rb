RSpec.describe Api::V1::ClassroomController, type: :request do
  let(:user) { FactoryBot.create(:user, teacher: true) }
  let(:credentials) { user.create_new_auth_token }
  let(:student_credentials) { User.first.create_new_auth_token }
  let(:headers1) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(student_credentials) }
  let(:headers_sad) { { HTTP_ACCEPT: 'application/json' } }

  before do
  	FactoryBot.create(:user, email: 'hey@gmail.com', student: true)
  	FactoryBot.create(:classroom, teacher_id: user.id, user_ids: [User.first.id])
  end

  describe "GET /api/v1/classroom" do
    it "should return all classes for a user that is a teacher" do
      get "/api/v1/classroom", headers: headers1
      
      expected_response = eval(file_fixture('user_classrooms.txt').read)
      expect(response_json).to eq expected_response.as_json
    end

    it "should return all classes for a user that is a student" do
      get "/api/v1/classroom", headers: headers2
      
      expected_response = eval(file_fixture('user_classrooms.txt').read)
      expect(response_json).to eq expected_response.as_json
    end

    it "should not return classes if user is not signed in" do
      get "/api/v1/classroom", headers: headers_sad

      expect(response_json["errors"][0]).to eq "You need to sign in or sign up before continuing."
	end
  end
end