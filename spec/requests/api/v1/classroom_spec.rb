RSpec.describe Api::V1::ClassroomController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:headers_sad) { { HTTP_ACCEPT: 'application/json' } }

  before do
     FactoryBot.create(:user, email: "bye@gmail.com")
     FactoryBot.create(:user, email: "hey@gmail.com")
  end

  describe "POST /api/v1/classroom" do
    context "with valid attribute values" do
      it "successfully creates classroom & students to it" do
        post "/api/v1/classroom", params: { 
        	classroom: {
          	name: "Math", grade: 10, 
          	user_ids: [User.first.id, User.second.id] }
        }, headers: headers
        
        expect(response.status).to eq 200
      end
    end

    context "without valid attribute values" do
      it "does not create classroom if name is blank" do
         post "/api/v1/classroom", params: { 
        	classroom: {
              grade: 10, 
          	user_ids: [User.first.id, User.second.id] }
        }, headers: headers
        
        expect(response.status).to eq 422
        expect(response_json['errors'][0]).to eq "Name can't be blank"
      end

      it "does not create classroom if grade is blank" do
         post "/api/v1/classroom", params: { 
        	classroom: {
              name: "Math", 
          	user_ids: [User.first.id, User.second.id] }
        }, headers: headers
         
        expect(response.status).to eq 422
        expect(response_json['errors'][0]).to eq "Grade can't be blank"
      end

      it "does not create classroom if user_ids are blank" do
         post "/api/v1/classroom", params: { 
        	classroom: {
              name: "Math", grade: 10 }
        }, headers: headers
        
        expect(response.status).to eq 422
        expect(response_json['errors']).to eq "Students must be added"
      end
    end
  end

  describe "DELETE /api/v1/classroom/:id" do
    before { FactoryBot.create(:classroom, teacher_id: user.id, user_ids: [User.first.id, User.second.id]) }
    it "successfully deletes classroom" do
      delete "/api/v1/classroom/#{Classroom.first.id}", headers: headers

      expect(response.status).to eq 200
    end
  end

  describe "PUT /api/v1/classroom/:id" do
    before { FactoryBot.create(:classroom, teacher_id: user.id, user_ids: [User.first.id, User.second.id]) }
    context "with valid attribute values" do
      it "successfully updates classroom" do
        put "/api/v1/classroom/#{Classroom.first.id}", params: {
          classroom: { user_ids: [User.first.id] }
        }, headers: headers

        expect(response.status).to eq 200
      end
    end

    context "without valid attribute values" do
      it "does not update classroom if grade is blank" do
        put "/api/v1/classroom/#{Classroom.first.id}", params: {
          classroom: { grade: nil }
        }, headers: headers

        expect(response.status).to eq 422
        expect(response_json["errors"][0]).to eq "Grade can't be blank"
      end

      it "does not update classroom if name is blank" do
        put "/api/v1/classroom/#{Classroom.first.id}", params: {
          classroom: { name: nil }
         }, headers: headers

        expect(response.status).to eq 422
        expect(response_json["errors"][0]).to eq "Name can't be blank"
      end

      it "does not update classroom if user_ids are blank" do
        put "/api/v1/classroom/#{Classroom.first.id}", params: {
          classroom: { user_ids: nil }
         }, headers: headers

        expect(response.status).to eq 422
        expect(response_json["errors"]).to eq "Students must be added"
      end
    end
  end
end

