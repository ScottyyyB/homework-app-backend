RSpec.describe Api::V1::ClassroomController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
end