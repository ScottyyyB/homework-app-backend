RSpec.describe Api::V0::PingController, type: :request do
  describe "/api/v0/ping/index" do
  	it "should return pong" do
  	  get "/api/v0/ping"

  	  expect(response.status).to eq 200
  	  expect(JSON.parse(response.body)['message']).to eq "Pong"
  	end
  end
end