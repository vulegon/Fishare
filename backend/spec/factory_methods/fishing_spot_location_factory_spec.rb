require 'rails_helper'

RSpec.describe FishingSpotLocationFactory do
  let_it_be(:prefecture) { create(:prefecture) }
  let(:fishing_spot) { build(:fishing_spot) }

  describe '#build' do
    subject { described_class.new.build(create_params, fishing_spot.id) }
      let!(:fish) { create(:fish) }
      let(:create_params) { Api::V1::FishingSpots::CreateParameter.new(ActionController::Parameters.new(params)) }
      let(:params) {
        {
          name: 'name',
          de1scription: 'description',
          fishes: [
            {
              id: fish.id,
              name: fish.name
            }
          ],
          location: {
            prefecture: { id: prefecture.id, name: prefecture.name },
            latitude: 35.658034,
            longitude: 139.701636,
            address: '東京都渋谷区'
          }
        }
      }

    it '永続化されていないlocationが返ってくること' do
      expect(subject).to be_a(FishingSpotLocation)
      expect(subject.id).to be_present
      expect(subject).to have_attributes(
        fishing_spot_id: fishing_spot.id,
        prefecture_id: prefecture.id,
        address: '東京都渋谷区',
        latitude: 35.658034,
        longitude: 139.701636
      )
      expect(subject).not_to be_persisted
    end
  end
end
