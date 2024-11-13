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
end
