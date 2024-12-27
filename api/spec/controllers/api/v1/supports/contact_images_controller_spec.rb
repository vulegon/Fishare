require 'rails_helper'

describe Api::V1::Supports::ContactsController, type: :request do
  describe 'POST #generate_presigned_urls' do
    subject {
      post api_v1_supports_contact_images_put_presigned_urls_path, params: params
      response
    }

    context 'パラメータが正しいとき' do
      let(:params) {
        {
          images: [
            {
              file_name: 'サンプル1.jpg',
              content_type: 'image/jpeg'
            },
            {
              file_name: 'サンプル2.jpg',
              content_type: 'image/jpeg'
            }
          ]
        }
      }

      it 'ステータスコード200が返ってくること' do
        expect(subject).to have_http_status(:ok)
      end
    end

    context 'パラメータが不正なとき' do
      let(:params) {
        {
          images: [
            {
              file_name: 'サンプル1.jpg',
              content_type: 'image/jpeg'
            },
            {
              file_name: 'サンプル2.jpg',
            }
          ]
        }
      }

      it 'ステータスコード400が返ってくること' do
        expect(subject).to have_http_status(:bad_request)
      end
    end
  end
end
