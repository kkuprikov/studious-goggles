RSpec.describe Main::Actions::Workers::Create do
  let(:params) { Hash[name: 'John'] }

  it "works" do
    response = subject.call(params)
    expect(response).to be_successful
  end
end
