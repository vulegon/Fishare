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
      let(:params) { { email: admin_user.email, password: 'password123'} }

      it 'ステータスコード200が返ってくること' do
        expect(subject).to have_http_status(:ok)
        expect(subject.headers).to include('access-token', 'token-type', 'client', 'expiry', 'uid')
      end
    end

    context 'パラメータが不正なとき' do
      context '管理者権限を持っていないとき' do
        let(:params) { { email: user.email, password: 'password123'} }

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
    let(:headers) { admin_user.create_new_auth_token } # 正しいヘッダー情報を作成

    context 'ヘッダー情報が正しいとき' do
      it 'ログアウトが成功し、ステータスコード200が返ること' do
        expect(subject).to have_http_status(:ok)
        expect(JSON.parse(subject.body)['message']).to eq('ログアウトしました')
      end

      it 'トークンが削除されていること' do
        subject
        admin_user.reload
        expect(admin_user.tokens).to be_empty
      end
    end

    context 'ヘッダー情報が不正なとき' do
      let(:headers) { { 'client' => 'wrong', 'access-token' => 'wrong', 'uid' => 'wrong' } }

      it 'ユーザーが見つからず、ステータスコード404が返ること' do
        expect(subject).to have_http_status(:not_found)
        expect(JSON.parse(subject.body)['message']).to eq('ユーザーが見つかりません')
      end
    end

    context 'ヘッダー情報が不足しているとき' do
      let(:headers) { {} }

      it 'トークン情報が不足しているエラーが返ること' do
        expect(subject).to have_http_status(:unauthorized)
        expect(JSON.parse(subject.body)['message']).to eq('認証情報が不足しています')
      end
    end
  end
end
