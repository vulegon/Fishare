require 'rails_helper'

RSpec.describe ::Api::V1::FishingSpotLocations::Show::FishingSpotFishSerializer, type: :serializer do
  let_it_be(:fish) { create(:fish) }

  describe '#as_json' do
    subject { described_class.new(fish).as_json }

    it '整形されたfishing_spot_fishe_imageが返ってくること' do
      expect(subject).to eq(
        id: fish.id,
        name: fish.name
      )
    end
  end
end
