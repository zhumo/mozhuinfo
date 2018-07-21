RSpec.shared_examples Concerns::StateManagement do |action_name, state_name|
  let(:factory_key) { described_class.model_name.i18n_key }
  let(:instance) { FactoryBot.create(factory_key) }
  let(:attribute_name) { "#{state_name}_at" }
  let(:now) { Time.zone.now }

  context 'instance methods' do
    before do
      Timecop.freeze(now)
    end

    after do
      Timecop.return
    end

    describe "#mark_as#{state_name}" do
      it "sets #{state_name}_at to be current time" do
        expect(instance.send(attribute_name)).to be_nil
        expect(instance.send("mark_as_#{state_name}")).to be_truthy
        expect(instance.send(attribute_name)).to eq(now)
        instance.reload
        expect(instance.send(attribute_name)).to be_nil
      end
    end

    describe "##{action_name}" do
      context 'when valid' do
        it "sets and saves #{state_name}_at to be current time" do
          expect(instance.send(attribute_name)).to be_nil
          expect(instance.send(action_name)).to be_truthy
          expect(instance.send(attribute_name)).to eq(now)
          instance.reload
          expect(instance.send("#{state_name}?")).to be_truthy
        end
      end

      context 'when invalid' do
        before do
          allow(instance).to receive(:valid?).and_return(false)
        end

        it "returns false" do
          expect(instance.send(attribute_name)).to be_nil
          expect(instance.send(action_name)).to be_falsey
          expect(instance.send(attribute_name)).to eq(now)
          instance.reload
          expect(instance.send(attribute_name)).to be_nil
        end
      end
    end

    describe "##{action_name}!" do
      context 'when valid' do
        it "sets and saves #{state_name}_at to be current time" do
          expect(instance.send(attribute_name)).to be_nil
          expect(instance.send("#{action_name}!")).to be_truthy
          expect(instance.send(attribute_name)).to eq(now)
          instance.reload
          expect(instance.send("#{state_name}?")).to be_truthy
        end
      end

      context 'when invalid' do
        before do
          allow(instance).to receive(:valid?).and_return(false)
        end

        it "raises an error" do
          expect(instance.send(attribute_name)).to be_nil
          expect{ instance.send("#{action_name}!") }.to raise_error(ActiveRecord::RecordInvalid)
          instance.reload
          expect(instance.send(attribute_name)).to be_nil
        end
      end
    end

    describe "#mark_as_not_#{state_name}" do
      before do
        instance.send("mark_as_#{state_name}")
      end

      it "sets #{state_name}_at to be nil" do
        expect(instance.send(attribute_name)).to eq(now)
        instance.send("mark_as_not_#{state_name}")
        expect(instance.send(attribute_name)).to be_nil
        instance.reload
        expect(instance.send(attribute_name)).to be_nil
      end
    end

    describe "#un#{action_name}" do
      before do
        instance.send(action_name)
      end

      context 'when valid' do
        it "sets and saves #{state_name}_at to be nil" do
          expect(instance.send(attribute_name)).to eq(now)
          instance.send("un#{action_name}")
          expect(instance.send(attribute_name)).to be_nil
          instance.reload
          expect(instance.send(attribute_name)).to be_nil
        end
      end

      context 'when invalid' do
        before do
          allow(instance).to receive(:valid?).and_return(false)
        end

        it 'returns false' do
          expect(instance.send(attribute_name)).to eq(now)
          expect(instance.send(action_name)).to be_falsey
          expect(instance.send(attribute_name)).to eq(now)
          instance.reload
          expect(instance.send("#{state_name}?")).to be_truthy
        end
      end
    end

    describe "#un#{action_name}!" do
      before do
        instance.send(action_name)
      end

      context 'when valid' do
        it "sets and saves #{state_name}_at to be nil" do
          expect(instance.send(attribute_name)).to eq(now)
          instance.send("un#{action_name}!")
          expect(instance.send(attribute_name)).to be_nil
          instance.reload
          expect(instance.send(attribute_name)).to be_nil
        end
      end

      context 'when invalid' do
        before do
          allow(instance).to receive(:valid?).and_return(false)
        end

        it 'raises an error' do
          expect(instance.send(attribute_name)).to eq(now)
          expect{ instance.send("un#{action_name}!") }.to raise_error(ActiveRecord::RecordInvalid)
          instance.reload
          expect(instance.send("#{state_name}?")).to be_truthy
        end
      end
    end

    describe "##{state_name}?" do
      context "when #{state_name}" do
        before do
          instance.send(action_name)
        end

        it 'returns true' do
          expect(instance.send("#{state_name}?")).to be_truthy
        end
      end

      context "when not #{state_name}" do
        before do
          instance.send("un#{action_name}")
        end

        it 'returns false' do
          expect(instance.send("#{state_name}?")).to be_falsey
        end
      end
    end
  end

  context 'ActiveRecord scopes' do
    let!(:is) do
      FactoryBot.create(factory_key).tap do |instance|
        instance.send(action_name)
      end
    end
    let!(:aint) do
      FactoryBot.create(factory_key).tap do |instance|
        instance.send("un#{action_name}")
      end
    end

    describe ".#{state_name}" do
      it "returns records that are #{state_name}" do
        expect(described_class.send(state_name)).to match_array([is])
      end
    end

    describe ".not_#{state_name}" do
      it "returns records that are not #{state_name}" do
        expect(described_class.send("not_#{state_name}")).to match_array([aint])
      end
    end
  end
end
