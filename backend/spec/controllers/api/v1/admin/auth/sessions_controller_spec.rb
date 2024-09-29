require 'rails_helper'

describe Api::V1::Admin::Auth::SessionsController, type: :request do
  describe 'POST #create' do
    subject {
      post api_v1_admin_user_session_path, params: params
      response
    }

    let!(:admin_user) { create(:user, :admin) }
    context 'パラメータが正しいとき' do
      let(:params) { { email: admin_user.email, password: 'password123'} }

      it 'ステータスコード200が返ってくること' do
        expect(subject).to have_http_status(:ok)
        parsed_response = JSON.parse(subject.body)
        expect(parsed_response['data']).to include(
          'id' => admin_user.id,
          'name' => admin_user.name,
          'email' => admin_user.email
        )
        headers = response.headers
        expect(headers).to have_key('access-token')
        expect(headers).to have_key('token-type')
        expect(headers).to have_key('client')
        expect(headers).to have_key('expiry')
        expect(headers).to have_key('uid')
      end
    end

    context 'パラメータが不正なとき' do
      let(:params) { { email: 'invalid', password: '12345678'} }

      it 'ログアウトして401を返すこと' do

        expect(subject).to have_http_status(:unauthorized)
      end
    end
  end
end
