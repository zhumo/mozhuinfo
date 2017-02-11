require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    before { post :create, params: params }

    context 'credentials set in ENV' do
      context 'incorrect username' do
        let(:params) { { username: 'username', password: 'wrong' } }

        it { should redirect_to login_path }
        it { should set_flash[:error].to('Unable to authenticate') }
      end

      context 'correct username' do
        let(:params) { { username: 'mozhu888', password: 'password' } }

        it { should redirect_to blogs_path }
        it { should set_session[:token] }
      end
    end
  end
end
