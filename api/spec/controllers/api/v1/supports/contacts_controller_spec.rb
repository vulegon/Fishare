require 'rails_helper'

describe Api::V1::Supports::ContactsController, type: :request do
  describe 'POST #create' do
    subject {
      post api_v1_supports_contact_path, params: params
      response
    }

    context 'パラメータが正しいとき' do
      let(:params) { { name: 'テスト太郎', email: 'walkurepqrt@gmail.com', content: '1' * 10, images: [], contact_category: 'other' } }

      it 'ステータスコード200が返ってくること' do
        expect(subject).to have_http_status(:ok)
      end
    end

    context 'パラメータが不正なとき' do
      let(:params) { { name: '', email: '', content: '', images: []} }

      it 'ステータスコード400が返ってくること' do
        expect(subject).to have_http_status(:bad_request)
      end
    end
  end
end
