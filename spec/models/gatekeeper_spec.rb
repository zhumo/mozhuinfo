require 'rails_helper'

RSpec.describe Gatekeeper do
  describe '#allow?' do
    context 'authentication by credentials' do
      let(:username) { 'mozhu' }
      let(:password) { 'poop' }
      let(:gatekeeper) { Gatekeeper.new(username: username, password: password) }

      context 'no credentials set' do
        it 'returns false' do
          expect(gatekeeper.allow?).to be_falsey
        end
      end

      context 'username is set' do
        before do
          ENV["AUTH_USERNAME"] = username
        end

        after do
          ENV.delete("AUTH_USERNAME")
        end

        it 'returns false' do
          expect(gatekeeper.allow?).to be_falsey
        end
      end

      context 'password is set' do
        before do
          ENV["AUTH_PASSWORD"] = password
        end

        after do
          ENV.delete("AUTH_PASSWORD")
        end

        it 'returns false' do
          expect(gatekeeper.allow?).to be_falsey
        end
      end

      context 'password and username is set' do
        before do
          ENV["AUTH_USERNAME"] = username
          ENV["AUTH_PASSWORD"] = password
        end

        after do
          ENV.delete("AUTH_USERNAME")
          ENV.delete("AUTH_PASSWORD")
        end

        context 'incorrect username and password' do
          let(:gatekeeper) { Gatekeeper.new(username: 'incorrect', password: 'wrong') }

          it 'returns false' do
            expect(gatekeeper.allow?).to be_falsey
          end
        end

        context 'correct username' do
          let(:gatekeeper) { Gatekeeper.new(username: username, password: 'wrong') }

          it 'returns false' do
            expect(gatekeeper.allow?).to be_falsey
          end
        end

        context 'correct password' do
          let(:gatekeeper) { Gatekeeper.new(username: 'incorrect', password: password) }

          it 'returns false' do
            expect(gatekeeper.allow?).to be_falsey
          end
        end

        context 'correct username and password' do
          it 'returns true' do
            expect(gatekeeper.allow?).to be_truthy
          end
        end
      end
    end

    context 'authentication by session key' do
      context 'no session exists' do
        let(:gatekeeper) { Gatekeeper.new(session_key: SecureRandom.hex) }

        it 'returns false' do
          expect(gatekeeper.allow?).to be_falsey
        end
      end

      context 'a session exists' do
        context 'key matches existing session' do
          let(:gatekeeper) { Gatekeeper.new(session_key: session.token) }

          context 'the session was created less than a week ago' do
            let!(:session) { FactoryGirl.create(:session, created_at: 1.week.ago + 1.second) }

            it 'returns true' do
              expect(gatekeeper.allow?).to be_truthy
            end
          end

          context 'the session was created over a week ago' do
            let!(:session) { FactoryGirl.create(:session, created_at: 1.week.ago - 1.second) }

            it 'returns false' do
              expect(gatekeeper.allow?).to be_falsey
            end
          end
        end

        context 'key does not match existing session' do
          let!(:session) { FactoryGirl.create(:session) }
          let(:gatekeeper) { Gatekeeper.new(session_key: SecureRandom.hex) }


          it 'returns false' do
            expect(gatekeeper.allow?).to be_falsey
          end
        end
      end
    end
  end
end
