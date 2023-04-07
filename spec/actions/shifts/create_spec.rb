RSpec.describe Main::Actions::Shifts::Create do
  let(:john) { Factory[:worker] }
  let(:peter) { Factory[:worker] }
  let(:frank) { Factory[:worker] }
  let(:bill) { Factory[:worker] }
  let(:params) { { shift: { worker_id: john.id, day: '2023-01-01' } } }

  context "with valid params" do
    it "creates a single shift" do
      expect(subject.call(params)).to be_successful
    end
  end

  describe "scheduling conflicts" do
    it "should not create two shift for the same worker" do
      Factory[:shift, day: '2023-01-01', worker_id: john.id, interval: 0]
      expect(subject.call(params)).not_to be_successful
    end
    
    it "should not create more than three shifts on a same day" do
      Factory[:shift, day: '2023-01-01', worker_id: bill.id, interval: 0]
      Factory[:shift, day: '2023-01-01', worker_id: peter.id, interval: 1]
      Factory[:shift, day: '2023-01-01', worker_id: frank.id, interval: 2]
      Factory[:shift, day: '2023-01-02', worker_id: frank.id, interval: 2]
      expect(subject.call(params)).not_to be_successful
    end
    
    it "should not create a shift for the same time" do
      Factory[:shift, day: '2023-01-01', worker_id: john.id, interval: 0]
      expect(subject.call(params)).not_to be_successful
    end

  end
end
