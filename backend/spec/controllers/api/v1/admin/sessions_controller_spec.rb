require 'rails_helper'

describe Api::V1::Admin::SessionsController, type: :request do
  describe 'POST #create' do
    subject {
      post api_v1_admin_sign_in_path, params: params
      response
    }

    let!(:admin_user) { create(:user, :admin) }
    context 'パラメータが正しいとき' do
      let(:params) { { email: admin_user.email, password: 'password' } }

      it 'ダッシュボード画面にリダイレクトされること' do
        expect(subject).to have_http_status(:found)
        expect(subject).to redirect_to(api_v1_admin_dashboards_path)
      end
    end

    context 'パラメータが不正なとき' do
      let(:params) { { email: 'invalid', password: '12345678'} }

      it 'ログイン画面にリダイレクトされること' do
        expect(subject).to redirect_to(api_v1_admin_sign_in_path)
      end
    end
  end
end
