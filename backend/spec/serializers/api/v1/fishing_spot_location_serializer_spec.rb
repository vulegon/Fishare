require 'rails_helper'

RSpec.describe ::Api::V1::FishingSpotLocationSerializer, type: :serializer do
  let_it_be(:fishing_spot) { create(:fishing_spot) }
  let_it_be(:prefecture) { create(:prefecture) }
  let_it_be(:fishing_spot_location) { create(:fishing_spot_location, fishing_spot: fishing_spot, prefecture: prefecture) }

  describe '#as_json' do
    subject { described_class.new(fishing_spot_location).as_json }

    it '整形されたfishing_spot_locationが返ってくること' do
      expect(subject).to eq(
        id: fishing_spot_location.id,
        fishing_spot_id: fishing_spot.id,
        prefecture_id: prefecture.id,
        latitude: fishing_spot_location.latitude,
        longitude: fishing_spot_location.longitude,
        address: fishing_spot_location.address
      )
    end
  end
end
