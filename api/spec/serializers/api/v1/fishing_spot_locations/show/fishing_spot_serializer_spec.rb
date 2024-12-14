require 'rails_helper'

RSpec.describe ::Api::V1::FishingSpotLocations::Show::FishingSpotSerializer, type: :serializer do
  let_it_be(:fishing_spot) { create(:fishing_spot) }
  let_it_be(:prefecture) { create(:prefecture) }
  let_it_be(:fishing_spot_location) { create(:fishing_spot_location, fishing_spot: fishing_spot, prefecture: prefecture) }
  let_it_be(:fish_1) { create(:fish, name: '魚1', display_order: 0) }
  let_it_be(:fish_2) { create(:fish, name: '魚2', display_order: 1) }

  describe '#as_json' do
    subject { described_class.new(fishing_spot, fishing_spot_location: fishing_spot_location).as_json }

    let!(:fishing_spot_fish_1) { create(:fishing_spot_fish, fishing_spot: fishing_spot, fish: fish_1) }
    let!(:fishing_spot_fish_2) { create(:fishing_spot_fish, fishing_spot: fishing_spot, fish: fish_2) }
    let!(:fishing_spot_image_1) { create(:fishing_spot_image, fishing_spot: fishing_spot, display_order: 0) }
    let!(:fishing_spot_image_2) { create(:fishing_spot_image, fishing_spot: fishing_spot, display_order: 1) }

    it '整形されたfishing_spot_fishesが返ってくること' do
      expect(subject).to eq(
        id: fishing_spot.id,
        name: fishing_spot.name,
        description: fishing_spot.description,
        prefecture_name: prefecture.name,
        latitude: fishing_spot_location.latitude,
        longitude: fishing_spot_location.longitude,
        address: fishing_spot_location.address,
        fishes: [
          { id: fish_1.id, name: fish_1.name },
          { id: fish_2.id, name: fish_2.name }
        ],
        images: [
          {
            id: fishing_spot_image_1.id,
            s3_key: fishing_spot_image_1.s3_key,
            file_name: fishing_spot_image_1.file_name,
            content_type: fishing_spot_image_1.content_type
          },
          {
            id: fishing_spot_image_2.id,
            s3_key: fishing_spot_image_2.s3_key,
            file_name: fishing_spot_image_2.file_name,
            content_type: fishing_spot_image_2.content_type
          }
        ]
      )
    end
  end
end
