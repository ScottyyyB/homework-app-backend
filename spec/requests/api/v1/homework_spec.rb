RSpec.describe Api::V1::HomeworkController, type: :request do
    let(:headers) { { HTTP_ACCEPT: "application/json" } }
  
  before do
    FactoryBot.create(:user, teacher: true)
    FactoryBot.create(:user, email: 'student1@gmail.com', student: true)
    FactoryBot.create(:user, email: 'student2@gmail.com', student: true)
    FactoryBot.create(:classroom, teacher_id: User.first.id, user_ids: [User.second.id, User.third.id] )
    headers.merge!("Authorization": "Token #{User.first.auth_token}")
  end
  
  describe "POST /api/v1/classrooms/:classroom_id/homework" do
    context "with valid attribute values" do
      it "succcessfully creates homework" do
        post "/api/v1/classrooms/#{Classroom.first.id}/homework", params: {
        	homework: 
        	{ title: "Case Study", link: "google-drive",
        	  due_date: "#{Date.tomorrow}", category: "Worksheet", teacher_id: User.first.id
        	}
        }, headers: headers

        expect(response.status).to eq 200
      end
    end

    context "without valid attribute values" do
      it "does not create if title is blank" do
        post "/api/v1/classrooms/#{Classroom.first.id}/homework", params: {
          homework: 
          { title: "", link: "google-drive",
            due_date: "#{Date.tomorrow}", category: "Worksheet", teacher_id: User.first.id
          }
        }, headers: headers
    

        expect(response_json["errors"][0]).to eq "Title can't be blank"
        expect(response.status).to eq 422
      end

      it "does not creaate if due_date is blank" do
        post "/api/v1/classrooms/#{Classroom.first.id}/homework", params: {
          homework: 
          { title: "Case Study", link: "google-drive",
            due_date: "", category: "Worksheet", teacher_id: User.first.id
          }
        }, headers: headers

        expect(response_json["errors"][0]).to eq "Due date can't be blank"
        expect(response.status).to eq 422
      end

      it "does not create if category is not included in VALID_CATEGORIES constant" do
        post "/api/v1/classrooms/#{Classroom.first.id}/homework", params: {
          homework: 
          { title: "Case Study", link: "google-drive",
            due_date: "#{Date.tomorrow}", category: "Paper", teacher_id: User.first.id          }
        }, headers: headers 

        expect(response_json["errors"][0]).to eq "Category must be either: Assignment, Worksheet or Study"
        expect(response.status).to eq 422
      end
    end
  end

  before { FactoryBot.create(:homework, teacher_id: User.first.id, user_id: User.second.id, classroom_id: Classroom.first.id) }
  
  describe "DELETE /api/v1/classrooms/:classroom_id/homework/:id" do
    it "successfully deletes homework" do
      delete "/api/v1/classrooms/#{Classroom.first.id}/homework/#{Homework.first.id}", headers: headers
        expect(response.status).to eq 200
    end
  end

  describe "PUT /api/v1/classrooms/:classroom_id/homework/:id" do
    context "with valid atrribute values" do
      it "successfully updates homework" do
        put "/api/v1/classrooms/#{Classroom.first.id}/homework/#{Homework.first.id}", params: {
          homework: 
          {
            due_date: Date.today
          }
        }, headers: headers

        expect(response.status).to eq 200 
      end
    end
    
    context "without valid atribute values" do
      it "does not update if title is blank" do
        put "/api/v1/classrooms/#{Classroom.first.id}/homework/#{Homework.first.id}", params: {
          homework: 
          {
            title: ""
          }
        }, headers: headers

        expect(response_json["errors"][0]).to eq "Title can't be blank"
        expect(response.status).to eq 422
      end

      it "does not update if due_date is blank" do
        put "/api/v1/classrooms/#{Classroom.first.id}/homework/#{Homework.first.id}", params: {
          homework: 
          {
            due_date: ""
          }
        }, headers: headers

        expect(response_json["errors"][0]).to eq "Due date can't be blank"
        expect(response.status).to eq 422
      end

      it "does not update if category is not included in VALID_CATEGORIES constant" do
        put "/api/v1/classrooms/#{Classroom.first.id}/homework/#{Homework.first.id}", params: {
          homework: 
          {
            category: ""
          }
        }, headers: headers

        expect(response_json["errors"][0]).to eq "Category must be either: Assignment, Worksheet or Study"
        expect(response.status).to eq 422
      end
    end
  end
end