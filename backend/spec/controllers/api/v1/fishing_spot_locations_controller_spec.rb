require 'rails_helper'

describe Api::V1::FishingSpotLocationsController, type: :request do
  let_it_be(:prefecture) { create(:prefecture) }
  let_it_be(:fishing_spot) { create(:fishing_spot) }
  let_it_be(:fishing_spot_location) { create(:fishing_spot_location, fishing_spot: fishing_spot, prefecture: prefecture) }

  describe 'GET #index' do
    subject {
      get api_v1_fishing_spot_locations_path
      response
    }

    it 'ステータスコード200が返ってくること' do
      expect(subject).to have_http_status(:ok)
    end
  end

  describe 'GET #fishing_spot' do
    subject {
      get api_v1_fishing_spot_location_fishing_spot_path(fishing_spot_location_id)
      response
    }

    context '存在する釣り場位置IDを指定した場合' do
      let(:fishing_spot_location_id) { fishing_spot_location.id }

      it 'ステータスコード200が返ってくること' do
        expect(subject).to have_http_status(:ok)
      end
    end

    context '存在しない釣り場位置IDを指定した場合' do
      let(:fishing_spot_location_id) { 1 }

      it 'ステータスコード404が返ってくること' do
        expect(subject).to have_http_status(:not_found)
      end
    end
  end
end
