require 'rails_helper'

RSpec.describe FishingSpotFishFactory do
  let_it_be(:fish_1) { create(:fish, name: 'fish1') }
  let_it_be(:fish_2) { create(:fish, name: 'fish2') }

  describe '#build' do
    subject { described_class.new.build(fish_id, fishing_spot_id) }

    let(:fish) { build(:fish) }
    let(:fish_id) { fish.id }
    let(:fishing_spot_id) { SecureRandom.uuid }

    it '永続化されていない釣り場と釣れる魚の中間テーブルが返ってくること' do
      expect(subject).to be_a(FishingSpotFish)
      expect(subject.id).to be_present
      expect(subject).to have_attributes(
        fishing_spot_id: fishing_spot_id,
        fish_id: fish.id
      )
      expect(subject).not_to be_persisted
    end
  end

  describe '#build_all' do
    subject { described_class.new.build_all(fish_ids, fishing_spot_id) }

    let(:fishing_spot_id) { SecureRandom.uuid }
    let(:fish_ids) { [fish_1.id, fish_2.id] }

    it '永続化されていない釣り場と釣れる魚の中間テーブルの配列が返ってくること' do
      expect(subject).to all(be_a(FishingSpotFish))
      expect(subject.size).to eq(2)
      expect(subject[0].id).to be_present
      expect(subject[0]).to have_attributes(
        fishing_spot_id: fishing_spot_id,
        fish_id: fish_ids[0]
      )
      expect(subject[0]).not_to be_persisted
      expect(subject[1].id).to be_present
      expect(subject[1]).to have_attributes(
        fishing_spot_id: fishing_spot_id,
        fish_id: fish_ids[1]
      )
      expect(subject[1]).not_to be_persisted
    end
  end
end
