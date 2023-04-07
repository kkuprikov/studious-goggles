RSpec.describe "GET /workers", type: [:request] do
  let(:worker) {Factory[:worker]}

  let(:request_headers) do
    {"HTTP_ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json"}
  end

  it 'lists workers' do
    Factory[:shift, :morning_shift, worker_id: worker.id, day: '2022-02-02']

    get '/workers'
    expect(last_response).to be_successful
    expect(JSON.parse(last_response.body).last['name']).to eq(worker.name)
  end
end