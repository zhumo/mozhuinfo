RSpec.shared_examples Concerns::StateManagement do |action_name, state_name|
  let(:factory_key) { described_class.model_name.i18n_key }
  let(:instance) { FactoryBot.create(factory_key) }
  let(:attribute_name) { "#{state_name}_at" }

  context 'instance methods' do
    # mark_as_deleted
    describe "#mark_as_#{state_name}" do
      subject { -> { instance.public_send("mark_as_#{state_name}") } }

      context "not #{state_name}" do
        it { should change { instance.public_send("#{state_name}?") }.from(false).to(true) }
        it { should_not change { instance.reload.public_send(attribute_name) }.from(nil) }
        it 'returns the time' do
          expect(subject.call).to be_a(Time)
        end
      end

      context "#{state_name}" do
        let(:instance) { FactoryBot.create(factory_key, state_name) }
        it { should_not change { instance.public_send(attribute_name) } }
        it { should_not change { instance.reload.public_send(attribute_name) } }
        it 'returns the time' do
          expect(subject.call).to be_a(Time)
        end
      end
    end

    # mark_as_not_deleted
    describe "#mark_as_not_#{state_name}" do
      subject { -> { instance.public_send("mark_as_not_#{state_name}") } }

      context "not #{state_name}" do
        it { should_not change { instance.public_send(attribute_name) }.from(nil) }
        it { should_not change { instance.reload.public_send(attribute_name) }.from(nil) }
        it 'returns nil' do
          expect(subject.call).to be_nil
        end
      end

      context "#{state_name}" do
        let(:instance) { FactoryBot.create(factory_key, state_name) }
        it { should change { instance.public_send(attribute_name) } }
        it { should_not change { instance.reload.public_send(attribute_name) } }
        it 'returns nil' do
          expect(subject.call).to be_nil
        end
      end
    end

    # delete
    describe "##{action_name}" do
      subject { -> { instance.public_send(action_name) } }

      context "not #{state_name}" do
        context 'when valid' do
          it { should change { instance.public_send(attribute_name) }.from(nil) }
          it { should change { instance.reload.public_send(attribute_name) }.from(nil) }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'when invalid' do
          before do
            allow(instance).to receive(:valid?).and_return(false)
          end

          it { should change { instance.public_send(attribute_name) }.from(nil) }
          it { should_not change { instance.reload.public_send(attribute_name) }.from(nil) }
          it 'returns false' do
            expect(subject.call).to be_falsey
          end
        end
      end

      context "#{state_name}" do
        let(:instance) { FactoryBot.create(factory_key, state_name) }

        context 'when valid' do
          it { should_not change { instance.public_send(attribute_name) } }
          it { should_not change { instance.reload.public_send(attribute_name) } }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'when invalid' do
          before do
            allow(instance).to receive(:valid?).and_return(false)
          end

          it { should_not change { instance.public_send(attribute_name) } }
          it { should_not change { instance.reload.public_send(attribute_name) } }
          it 'returns false' do
            expect(subject.call).to be_falsey
          end
        end
      end
    end

    # delete!
    describe "##{action_name}!" do
      subject { -> { instance.public_send("#{action_name}!") } }

      context "not #{state_name}" do
        context 'when valid' do
          it { should change { instance.public_send(attribute_name) }.from(nil) }
          it { should change { instance.reload.public_send(attribute_name) }.from(nil) }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'when invalid' do
          before do
            allow(instance).to receive(:valid?).and_return(false)
          end

          it { should raise_error(ActiveRecord::RecordInvalid) }
        end
      end

      context "#{state_name}" do
        let(:instance) { FactoryBot.create(factory_key, state_name) }

        context 'when valid' do
          it { should_not change { instance.public_send(attribute_name) } }
          it { should_not change { instance.reload.public_send(attribute_name) } }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'when invalid' do
          before do
            allow(instance).to receive(:valid?).and_return(false)
          end

          it { should raise_error(ActiveRecord::RecordInvalid) }
        end
      end
    end

    # undelete
    describe "#un#{action_name}" do
      subject { -> { instance.public_send("un#{action_name}") } }

      context "not #{state_name}" do
        context 'when valid' do
          it { should_not change { instance.public_send(attribute_name) }.from(nil) }
          it { should_not change { instance.reload.public_send(attribute_name) }.from(nil) }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'when invalid' do
          before do
            allow(instance).to receive(:valid?).and_return(false)
          end

          it { should_not change { instance.public_send(attribute_name) }.from(nil) }
          it { should_not change { instance.reload.public_send(attribute_name) }.from(nil) }
          it 'returns false' do
            expect(subject.call).to be_falsey
          end
        end
      end

      context "#{state_name}" do
        let(:instance) { FactoryBot.create(factory_key, state_name) }

        context 'when valid' do
          it { should change { instance.public_send(attribute_name) } }
          it { should change { instance.reload.public_send(attribute_name) } }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'when invalid' do
          before do
            allow(instance).to receive(:valid?).and_return(false)
          end

          it { should change { instance.public_send(attribute_name) } }
          it { should_not change { instance.reload.public_send(attribute_name) } }
          it 'returns false' do
            expect(subject.call).to be_falsey
          end
        end
      end
    end

    # undelete!
    describe "#un#{action_name}!" do
      subject { -> { instance.public_send("un#{action_name}!") } }

      context "not #{state_name}" do
        context "when valid" do
          it { should_not change { instance.public_send(attribute_name) }.from(nil) }
          it { should_not change { instance.reload.public_send(attribute_name) }.from(nil) }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'when invalid' do
          before do
            allow(instance).to receive(:valid?).and_return(false)
          end

          it { should raise_error(ActiveRecord::RecordInvalid) }
        end
      end

      context "#{state_name}" do
        let(:instance) { FactoryBot.create(factory_key, state_name) }

        context 'when valid' do
          it { should change { instance.public_send(attribute_name) } }
          it { should change { instance.reload.public_send(attribute_name) } }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'when invalid' do
          before do
            allow(instance).to receive(:valid?).and_return(false)
          end

          it { should raise_error(ActiveRecord::RecordInvalid) }
        end
      end
    end

    # deleted?
    describe "##{state_name}?" do
      subject { -> { instance.public_send("#{state_name}?") } }
      context "#{state_name}" do
        let(:instance) { FactoryBot.create(factory_key, state_name) }
        it 'returns true' do
          expect(subject.call).to be_truthy
        end
      end

      context "not #{state_name}" do
        it 'returns false' do
          expect(subject.call).to be_falsey
        end
      end
    end

    # not_deleted?
    describe "##{state_name}?" do
      subject { -> { instance.public_send("not_#{state_name}?") } }
      context "when #{state_name}" do
        let(:instance) { FactoryBot.create(factory_key, state_name) }
        it 'returns false' do
          expect(subject.call).to be_falsey
        end
      end

      context "when not #{state_name}" do
        it 'returns true' do
          expect(subject.call).to be_truthy
        end
      end
    end


    # deleted=
    describe "#{state_name}=" do
      context "not #{state_name}" do
        context 'mark true' do
          subject { -> { instance.public_send("#{state_name}=", true) } }
          it { should change { instance.public_send(attribute_name) }.from(nil) }
          it { should_not change { instance.reload.public_send(attribute_name) }.from(nil) }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'mark false' do
          subject { -> { instance.public_send("#{state_name}=", false) } }
          it { should_not change { instance.public_send(attribute_name) }.from(nil) }
          it { should_not change { instance.reload.public_send(attribute_name) }.from(nil) }
          it 'returns false' do
            expect(subject.call).to be_falsey
          end
        end
      end

      context "#{state_name}" do
        let(:instance) { FactoryBot.create(factory_key, state_name) }

        context 'mark true' do
          subject { -> { instance.public_send("#{state_name}=", true) } }
          it { should_not change { instance.public_send(attribute_name) } }
          it { should_not change { instance.reload.public_send(attribute_name) } }
          it 'returns true' do
            expect(subject.call).to be_truthy
          end
        end

        context 'mark false' do
          subject { -> { instance.public_send("#{state_name}=", false) } }
          it { should change { instance.public_send(attribute_name) } }
          it { should_not change { instance.reload.public_send(attribute_name) } }
          it 'returns false' do
            expect(subject.call).to be_falsey
          end
        end
      end
    end
  end

  context 'ActiveRecord scopes' do
    let!(:is) { FactoryBot.create(factory_key, state_name) }
    let!(:aint) { FactoryBot.create(factory_key) }

    describe ".#{state_name}" do
      it "returns records that are #{state_name}" do
        expect(described_class.public_send(state_name)).to match_array([is])
      end
    end

    describe ".not_#{state_name}?" do
      it "returns records that are not #{state_name}" do
        expect(described_class.public_send("not_#{state_name}")).to match_array([aint])
      end
    end
  end
end
