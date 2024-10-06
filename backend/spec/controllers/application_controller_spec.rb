require 'rails_helper'

describe ApplicationController, type: :request do
  class ApplicationTestsController < ApplicationController
    before_action :authenticate_user!, only: [:check_authenticate_user]
    def check_authenticate_user
      render status: :ok, json: {}
    end

    def get_current_user
      json = { user: current_user }
      render status: :ok, json: json
    end
  end

  describe '#current_user' do
    subject {
      get '/test_current_user'
      response
    }

    before(:each) do
      Rails.application.routes.draw do
        get '/test_current_user', to: 'application_tests#get_current_user'
      end
    end

    after(:each) { Rails.application.reload_routes! }

    let!(:user) { create(:user) }
    let(:auth_token) { user.create_new_auth_token }

    context 'Cookieが正しいとき' do
      before do
        cookies[:access_token] = auth_token['access-token']
        cookies[:uid] = auth_token['uid']
        cookies[:client] = auth_token['client']
      end

      it 'ログインユーザーが取得できること' do
        expect(subject).to have_http_status(:ok)
        expect(JSON.parse(subject.body)['user']['id']).to eq(user.id)
      end
    end

    context 'Cookieが誤りの場合' do
      before do
        cookies[:access_token] = 'wrong'
        cookies[:uid] = 'wrong'
        cookies[:client] = 'wrong'
      end

      it 'ログインユーザーが取得できないこと' do
        expect(subject).to have_http_status(:ok)
        expect(JSON.parse(subject.body)['user']).to eq(nil)
      end
    end
  end

  describe '#authenticate_user!' do
    subject {
      get '/test_check_authenticate_user'
      response
    }

    before(:each) do
      Rails.application.routes.draw do
        get '/test_check_authenticate_user', to: 'application_tests#check_authenticate_user'
      end
    end

    after(:each) { Rails.application.reload_routes! }

    let!(:user) { create(:user) }
    let(:auth_token) { user.create_new_auth_token }

    context 'Cookieが正しいとき' do
      before do
        cookies[:access_token] = auth_token['access-token']
        cookies[:uid] = auth_token['uid']
        cookies[:client] = auth_token['client']
      end

      it 'ステータスコード200を返す' do
        expect(subject).to have_http_status(:ok)
      end
    end

    context 'Cookieが誤りの場合' do
      context '認証情報が不足している場合' do
        before do
          cookies[:access_token] = auth_token['access-token']
          cookies[:uid] = auth_token['uid']
        end

        it 'ステータスコード401を返す' do
          expect(subject).to have_http_status(:unauthorized)
        end
      end

      context '認証情報が不正な場合' do
        before do
          cookies[:access_token] = 'wrong'
          cookies[:uid] = 'wrong'
          cookies[:client] = 'wrong'
        end

        it 'ステータスコード404を返す' do
          expect(subject).to have_http_status(:not_found)
        end
      end
    end
  end
end
