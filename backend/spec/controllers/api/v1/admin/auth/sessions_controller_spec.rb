require 'rails_helper'

describe Api::V1::Admin::Auth::SessionsController, type: :request do
  describe 'POST #create' do
    subject {
      post api_v1_admin_auth_sign_in_path, params: params
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
      delete api_v1_admin_auth_sign_out_path
      response
    }
    let!(:admin_user) { create(:user, :admin) }
    let(:auth_token) { admin_user.create_new_auth_token }

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

    context 'クッキーが不正なとき' do
      before do
        cookies[:access_token] = auth_token['access-token']
        cookies[:uid] = auth_token['uid']
        cookies[:client] = 'wrong'
      end

      it 'ユーザーが見つからず、ステータスコード404が返ること' do
        expect(subject).to have_http_status(:not_found)
        expect(JSON.parse(subject.body)['message']).to eq('ユーザーが見つかりません')
      end
    end

    context 'ヘッダー情報が不足しているとき' do
      context 'access_tokenが不足しているとき' do
        before do
          cookies[:uid] = auth_token['uid']
          cookies[:client] = 'wrong'
        end

        it 'トークン情報が不足しているエラーが返ること' do
          expect(subject).to have_http_status(:unauthorized)
          expect(JSON.parse(subject.body)['message']).to eq('認証情報が不足しています')
        end
      end

      context 'uidが不足しているとき' do
        before do
          cookies[:uid] = auth_token['uid']
          cookies[:client] = 'wrong'
        end

        it 'トークン情報が不足しているエラーが返ること' do
          expect(subject).to have_http_status(:unauthorized)
          expect(JSON.parse(subject.body)['message']).to eq('認証情報が不足しています')
        end
      end

      context 'clientが不足しているとき' do
        before do
          cookies[:uid] = auth_token['uid']
          cookies[:client] = 'wrong'
        end

        it 'トークン情報が不足しているエラーが返ること' do
          expect(subject).to have_http_status(:unauthorized)
          expect(JSON.parse(subject.body)['message']).to eq('認証情報が不足しています')
        end
      end
    end
  end
end
