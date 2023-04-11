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

    context "with interval specified" do
      let(:params) { { shift: { worker_id: john.id, day: '2023-01-01', interval: 2 } } }
      it 'should propagate the interval parameter' do
        result = subject.call(params)
        expect(JSON.parse(result.body.last)["shift"]["interval"]).to eq(2)
      end
    end
  end

  describe "scheduling conflicts" do
    it "should not create two shift for the same worker" do
      Factory[:shift, :morning_shift, worker_id: john.id]
      expect(subject.call(params)).not_to be_successful
    end
    
    it "should not create more than three shifts on a same day" do
      Factory[:shift, :morning_shift, worker_id: bill.id]
      Factory[:shift, :day_shift, worker_id: peter.id]
      Factory[:shift, :evening_shift, worker_id: frank.id]
      expect(subject.call(params)).not_to be_successful
    end
    
    context "with interval specified" do
      let(:params) { { shift: { worker_id: john.id, day: '2023-01-01', interval: 2 } } }

      it "should not create a shift for the same interval" do
        Factory[:shift, :evening_shift, worker_id: peter.id]
        expect(subject.call(params)).not_to be_successful
      end
    end
  end
end
