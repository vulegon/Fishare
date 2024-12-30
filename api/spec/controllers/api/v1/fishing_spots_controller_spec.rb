require 'rails_helper'

describe Api::V1::FishingSpotsController, type: :request do
  let_it_be(:prefecture) { create(:prefecture) }
  let_it_be(:fish) { create(:fish) }
  let_it_be(:admin) { create(:user, :admin, email: 'admin@example.com') }
  let_it_be(:user) { create(:user, email: 'test_user@example.com') }

  describe 'POST #create' do
    subject {
      post api_v1_fishing_spots_path, params: params, headers: headers
      response
    }

    let(:params) {
      {
        name: '釣り場1',
        description: '1234567890',
        location: {
          prefecture: { id: prefecture.id, name: prefecture.name },
          address: '東京都渋谷区',
          latitude: 35.658034,
          longitude: 139.701636
        },
        images: [
          {
            s3_key: 'S3キー',
            file_name:  'ファイル名',
            content_type: 'ファイルの拡張子',
            file_size: 10,
            display_order: 1
          }
        ],
        fishes: [
          {
            id: fish.id,
            name: fish.name
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
            name: '釣り場1',
            description: '1234567890',
            location: {
              prefecture: { id: SecureRandom.uuid, name: '存在しない都道府県'},
              address: '東京都渋谷区',
              latitude: 35.658034,
              longitude: 139.701636
            },
            images: [
              {
                s3_key: 'S3キー',
                file_name:  'ファイル名',
                content_type: 'ファイルの拡張子',
                file_size: 10,
                display_order: 1
              }
            ],
            fishes: [
              {
                id: fish.id,
                name: fish.name
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
