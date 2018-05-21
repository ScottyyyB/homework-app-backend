RSpec.describe Api::V1::HomeworkController, type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
    
  before do
    FactoryBot.create(:user, teacher: true)
    FactoryBot.create(:user, email: 'student1@gmail.com', student: true)
    FactoryBot.create(:user, email: 'student2@gmail.com', student: true)
    FactoryBot.create(:classroom, teacher_id: User.first.id, user_ids: [User.second.id, User.third.id] )
    4.times { FactoryBot.create(:homework) }
    FactoryBot.create(:homework, status: "Completed")
    headers.merge!("Authorization": "Token #{User.second.auth_token}")
  end

  describe "GET /api/v1/classrooms/:classroom_id/homework" do
    it "should return all classes by specific status" do
      get "/api/v1/classrooms/#{Classroom.first.id}/homework", params: {
      	status: "Pending"
      }, headers: headers
        
      expect(response.status).to eq 200
      expected_response = eval(file_fixture("homework_index.txt").read)
      expect(response_json).to eq expected_response.as_json
	  end
  end  
end