require 'rails_helper'

describe Api::V1::Admin::Auth::SessionsController, type: :request do
  describe 'POST #create' do
    subject {
      post api_v1_admin_user_session_path, params: params
      response
    }

    let!(:admin_user) { create(:user, :admin, email: 'admin@fishare.com') }
    let!(:user) { create(:user, email: 'not_admin@fishare.com') }

    context 'パラメータが正しいとき' do
      let(:params) { { email: admin_user.email, password: 'Password123'} }

      it 'ステータスコード200が返ってくること' do
        expect(subject).to have_http_status(:ok)
        expect(subject.headers['Set-Cookie']).to include('access_token')
        expect(subject.headers['Set-Cookie']).to include('uid')
        expect(subject.headers['Set-Cookie']).to include('client')
      end
    end

    context 'パラメータが不正なとき' do
      context '管理者権限を持っていないとき' do
        let(:params) { { email: user.email, password: 'Password123'} }

        it '403を返すこと' do
          expect(subject).to have_http_status(:forbidden)
          expect(JSON.parse(subject.body)['message']).to eq('管理者権限を持っていません')
        end
      end

      context 'メールアドレスまたはパスワードに誤りがあるとき' do
        let(:params) { { email: admin_user.email, password: 'wrong'} }

        it '401を返すこと' do
          expect(subject).to have_http_status(:unauthorized)
          expect(JSON.parse(subject.body)['message']).to eq('メールアドレスまたはパスワードに誤りがあります')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject {
      delete destroy_api_v1_admin_user_session_path, headers: headers
      response
    }
    let!(:admin_user) { create(:user, :admin) }
    let(:auth_token) { admin_user.create_new_auth_token }
    let(:headers) { auth_token }

    context 'クッキーが正しいとき' do
      before do
        cookies[:access_token] = auth_token['access-token']
        cookies[:uid] = auth_token['uid']
        cookies[:client] = auth_token['client']
        sign_in(admin_user)
      end

      it 'ログアウトが成功し、ステータスコード200が返ること' do
        expect{ subject }.to change{ cookies[:access_token] }.from(auth_token['access-token']).to('').
          and change{ cookies[:uid] }.from(auth_token['uid']).to('').
          and change{ cookies[:client] }.from(auth_token['client']).to('')
        expect(admin_user.reload.tokens[auth_token['client']]).to be_nil
        expect(subject).to have_http_status(:ok)
      end
    end

    context 'ヘッダーが不正なとき' do
      let(:headers) { { 'access-token' => 'wrong', 'client' => 'wrong', 'uid' => 'wrong' } }

      it 'ユーザーが見つからず、ステータスコード404が返ること' do
        expect(subject).to have_http_status(:unauthorized)
      end
    end

    context 'ヘッダー情報が不足しているとき' do
      context 'access_tokenが不足しているとき' do
        let(:headers) { { 'client' => auth_token['client'], 'uid' => auth_token['uid'] } }

        it 'トークン情報が不足しているエラーが返ること' do
          expect(subject).to have_http_status(:unauthorized)
        end
      end

      context 'uidが不足しているとき' do
        let(:headers) { { 'client' => auth_token['client'], 'access-token' => auth_token['access-token'] } }

        it 'トークン情報が不足しているエラーが返ること' do
          expect(subject).to have_http_status(:unauthorized)
        end
      end

      context 'clientが不足しているとき' do
        let(:headers) { { 'access-token' => auth_token['access-token'], 'uid' => auth_token['uid'] } }

        it 'トークン情報が不足しているエラーが返ること' do
          expect(subject).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
