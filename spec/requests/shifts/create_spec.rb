require 'byebug'
RSpec.describe "POST /shifts", type: [:request] do
  let(:worker) { Factory[:worker] }

  let(:request_headers) do
    {"HTTP_ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json"}
  end

  context 'given valid params' do
    let(:params) do
      { shift: { worker_id: worker.id, day: '2023-01-01' } }
    end

    it 'schedules a shift' do
      post "/shifts", params.to_json, request_headers
      expect(last_response).to be_created
    end
  end

  context 'given invalid params' do
    let(:params) do
      { shift: { worker_id: 0, day: '2023-01-01' } }
    end

    it 'returns an error' do
      post "/shifts", params.to_json, request_headers
      expect(last_response.status).to eq(400)
    end
  end
end