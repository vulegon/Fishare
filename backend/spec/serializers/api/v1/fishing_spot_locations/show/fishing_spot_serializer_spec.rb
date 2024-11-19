require 'rails_helper'

RSpec.describe ::Api::V1::FishingSpots::Show::FishingSpotSerializer, type: :serializer do
  let_it_be(:fishing_spot) { create(:fishing_spot) }
  let_it_be(:prefecture) { create(:prefecture) }
  let_it_be(:fishing_spot_location) { create(:fishing_spot_location, fishing_spot: fishing_spot, prefecture: prefecture) }
  let_it_be(:fish_1) { create(:fish) }
  let_it_be(:fish_2) { create(:fish) }

  describe '#as_json' do
    subject { described_class.new(fishing_spot, fishing_spot_location: fishing_spot_location).as_json }

    context 'fishing_spot_fishesに関して' do
      context 'fishesが存在する場合' do
        let!(:fishing_spot_fish_1) { create(:fishing_spot_fish, fishing_spot: fishing_spot, fish: fish_1) }
        let!(:fishing_spot_fish_2) { create(:fishing_spot_fish, fishing_spot: fishing_spot, fish: fish_2) }

        it '整形されたfishing_spot_fishesが返ってくること' do
          expect(subject).to include(
            
          )
        end
      end

      context 'fishesが存在しない場合' do

      end
    end

    context 'fishing_spot_imagesに関して' do

    end
  end
end
