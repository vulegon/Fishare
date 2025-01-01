require 'rails_helper'

RSpec.describe ::Api::V1::FishingSpots::Index::PaginationSerializer, type: :serializer do
  let_it_be(:prefecture_1) { create(:prefecture, name: '東京都') }
  let_it_be(:prefecture_2) { create(:prefecture, name: '神奈川県') }
  let_it_be(:fish_1) { create(:fish, name: '魚1') }
  let_it_be(:fish_2) { create(:fish, name: '魚2') }
  let_it_be(:fish_3) { create(:fish, name: '魚3') }
  let_it_be(:fishing_spot_1) { create(:fishing_spot) }
  let_it_be(:fishing_spot_fish_1) { create(:fishing_spot_fish, fishing_spot_id: fishing_spot_1.id, fish_id: fish_1.id) }
  let_it_be(:fishing_spot_fish_2) { create(:fishing_spot_fish, fishing_spot_id: fishing_spot_1.id, fish_id: fish_2.id) }
  let_it_be(:fishing_spot_location_1) { create(:fishing_spot_location, fishing_spot_id: fishing_spot_1.id, prefecture_id: prefecture_1.id) }
  let_it_be(:fishing_spot_2) { create(:fishing_spot) }
  let_it_be(:fishing_spot_fish_3) { create(:fishing_spot_fish, fishing_spot_id: fishing_spot_2.id, fish_id: fish_3.id) }
  let_it_be(:fishing_spot_location_2) { create(:fishing_spot_location, fishing_spot_id: fishing_spot_2.id, prefecture_id: prefecture_2.id) }

  describe '#as_json' do
    subject { described_class.new(fishing_spots, count: fishing_spots.count).as_json }

    let(:fishing_spots) { FishingSpot.all.offset(0).limit(10) }

    it '整形されたfishing_spot_locationが返ってくること' do
      expect(subject).to eq(
        fishing_spots: [
          {
            id: fishing_spot_1.id,
            name: fishing_spot_1.name,
            description: fishing_spot_1.description,
            locations: [
              {
                prefecture: { id: prefecture_1.id, name: prefecture_1.name }
              }
            ],
            fishes: [
              { id: fish_1.id, name: fish_1.name },
              { id: fish_2.id, name: fish_2.name }
            ]
          },
          {
            id: fishing_spot_2.id,
            name: fishing_spot_2.name,
            description: fishing_spot_2.description,
            locations: [
              {
                prefecture: { id: prefecture_2.id, name: prefecture_2.name }
              }
            ],
            fishes: [
              { id: fish_3.id, name: fish_3.name },
            ]
          }
        ],
        count: 2,
        offset: 0,
        limit: 10,
      )
    end
  end
end
