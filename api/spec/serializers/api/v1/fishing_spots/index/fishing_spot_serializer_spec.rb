require 'rails_helper'

RSpec.describe ::Api::V1::FishingSpots::Index::FishingSpotSerializer, type: :serializer do
  let_it_be(:prefecture) { create(:prefecture) }
  let_it_be(:fish) { create(:fish) }
  let_it_be(:fishing_spot) { create(:fishing_spot) }
  let_it_be(:fishing_spot_fish) { create(:fishing_spot_fish, fishing_spot_id: fishing_spot.id, fish_id: fish.id) }
  let_it_be(:fishing_spot_location) { create(:fishing_spot_location, fishing_spot_id: fishing_spot.id, prefecture_id: prefecture.id) }

  describe '#as_json' do
    subject { described_class.new(fishing_spot).as_json }

    it '整形されたfishing_spot_locationが返ってくること' do
      expect(subject).to eq(
        id: fishing_spot.id,
        name: fishing_spot.name,
        description: fishing_spot.description,
        locations: [
          {
            prefecture: { id: prefecture.id, name: prefecture.name }
          }
        ],
        fishes: [
          { id: fish.id, name: fish.name }
        ]
      )
    end
  end
end
