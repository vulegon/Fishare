require 'rails_helper'

describe Api::V1::FishingSpotImagesController, type: :request do
  let_it_be(:admin) { create(:user, :admin, email: 'admin@example.com') }
  let_it_be(:user) { create(:user, email: 'test_user@example.com') }

  describe 'POST #generate_presigned_urls' do
    subject {
      post api_v1_fishing_spot_images_generate_presigned_urls_path, params: params, headers: headers
      response
    }

    let(:params) {
      {
        images: [
          {
            file_name:  'ファイル名.jpeg',
            content_type: 'image/jpeg',
          }
        ]
      }
    }

    context '管理者の場合' do
      let (:headers) { admin.create_new_auth_token }

      context 'パラメータが正しいとき' do
        it 'ステータスコード200が返ってくること' do
          expect(subject).to have_http_status(:ok)
        end
      end

      context 'パラメータが不正なとき' do
        let(:params) {
          {
            images: [
              {
                file_name:  'ファイル名.jpeg',
                content_type: '',
              }
            ]
          }
        }

        it 'ステータスコード400が返ってくること' do
          expect(subject).to have_http_status(:bad_request)
        end
      end
    end

    context '管理者以外の場合' do
      let (:headers) { user.create_new_auth_token }

      it 'ステータスコード403が返ってくること' do
        expect(subject).to have_http_status(:forbidden)
      end
    end
  end
end
