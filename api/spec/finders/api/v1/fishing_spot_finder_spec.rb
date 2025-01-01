require 'rails_helper'

RSpec.describe Api::V1::FishingSpotFinder, type: :finder do
  let_it_be(:tokyo_prefecture) { create(:prefecture, name: '東京都') }
  let_it_be(:kanagawa_prefecture) { create(:prefecture, name: '神奈川県') }
  let_it_be(:fish_1) { create(:fish, name: '魚1') }
  let_it_be(:fish_2) { create(:fish, name: '魚2') }
  let_it_be(:fishing_spot_1) { create(:fishing_spot, name: '釣り場A', updated_at: Time.zone.parse('2025-01-01 00:00:01')) }
  let_it_be(:fishing_spot_location_1) { create(:fishing_spot_location, fishing_spot_id: fishing_spot_1.id, prefecture_id: tokyo_prefecture.id) }
  let_it_be(:fishing_spot_fish_1) { create(:fishing_spot_fish, fishing_spot_id: fishing_spot_1.id, fish_id: fish_1.id) }
  let_it_be(:fishing_spot_fish_2) { create(:fishing_spot_fish, fishing_spot_id: fishing_spot_1.id, fish_id: fish_2.id) }
  let_it_be(:fishing_spot_2) { create(:fishing_spot, name: '釣り場B', updated_at: Time.zone.parse('2025-01-01 00:00:00')) }
  let_it_be(:fishing_spot_location_2) { create(:fishing_spot_location, fishing_spot_id: fishing_spot_2.id, prefecture_id: kanagawa_prefecture.id) }
  let_it_be(:fishing_spot_fish_3) { create(:fishing_spot_fish, fishing_spot_id: fishing_spot_2.id, fish_id: fish_2.id) }
  let_it_be(:fishing_spot_3) { create(:fishing_spot, name: '釣り場C', updated_at: Time.zone.parse('2025-01-01 00:00:00')) }
  let_it_be(:fishing_spot_location_2) { create(:fishing_spot_location, fishing_spot_id: fishing_spot_3.id, prefecture_id: tokyo_prefecture.id) }


  describe '#search' do
    subject { described_class.new.search(search_parameter) }

    let(:search_parameter) { ::Api::V1::FishingSpots::SearchParameter.new(ActionController::Parameters.new(params)) }

    before do
      search_parameter.valid?
    end

    context 'nameが指定されている場合' do
      let(:params) { { name: '釣り場A', offset: 0, limit: 10 } }

      it '指定したnameの釣り場が取得できること' do
        expect(subject).to eq([fishing_spot_1])
      end
    end

    context 'prefecture_idが指定されている場合' do
      let(:params) { { prefecture_id: tokyo_prefecture.id, offset: 0, limit: 10 } }

      it '指定したprefecture_idの釣り場が取得できること' do
        expect(subject).to eq([fishing_spot_1, fishing_spot_3])
      end
    end

    context 'fish_idが指定されている場合' do
      let(:params) { { fishes: [{id: fish_1.id}] } }

      it '指定したfish_idの釣り場が取得できること' do
        expect(subject).to eq([fishing_spot_1])
      end
    end
  end
end
