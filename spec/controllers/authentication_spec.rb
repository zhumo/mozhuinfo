require 'rails_helper'

class AuthenticatingController < ApplicationController
  include Concerns::Authentication
end

RSpec.describe AuthenticatingController, type: :controller do
  controller(AuthenticatingController) do
    def authenticated_action
      render plain: 'OK'
    end
  end

  let(:session) { Hash.new }

  before do
    routes.draw { get 'authenticated_action' => 'authenticating#authenticated_action' }
    get :authenticated_action, session: session
  end

  context 'no sessions in db' do
    it { should redirect_to login_path }
  end

  context 'with sessions in db' do
    let!(:session_record) { FactoryBot.create(:session) }

    context 'incorrect session key' do
      let(:session) { { token: 'abc123' } }

      it { should redirect_to login_path }
    end

    context 'correct session key' do
      let(:session) { { token: session_record.token } }

      context 'session is expired' do
        let!(:session_record) { FactoryBot.create(:session, :expired) }

        it { should redirect_to login_path }
      end

      context 'session is valid' do
        it 'should succeed' do
          expect(response).to be_success
        end
      end
    end
  end
end
