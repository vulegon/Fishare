# == Schema Information
#
# Table name: fishing_spots
#
#  id                :uuid             not null, primary key
#  description(説明) :text             not null
#  name(釣り場名)    :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe FishingSpot, type: :model do
  describe '#valid?' do
    subject { fishing_spot.valid? }

    describe 'nameに関して' do
      context 'nameがnilの場合' do
        let(:fishing_spot) { build(:fishing_spot, name: nil) }

        it { is_expected.to eq false }
      end

      context 'nameが空文字の場合' do
        let(:fishing_spot) { build(:fishing_spot, name: '') }

        it { is_expected.to eq false }
      end
    end

    describe 'descriptionに関して' do
      context 'descriptionがnilの場合' do
        let(:fishing_spot) { build(:fishing_spot, description: nil) }

        it { is_expected.to eq false }
      end

      context 'descriptionが空文字の場合' do
        let(:fishing_spot) { build(:fishing_spot, description: '') }

        it { is_expected.to eq false }
      end
    end
  end

  describe '#name_like' do
    subject { described_class.name_like(name) }

    let!(:fishing_spot1) { create(:fishing_spot, name: '釣り場A') }
    let!(:fishing_spot2) { create(:fishing_spot, name: '釣り場a') }
    let!(:fishing_spot3) { create(:fishing_spot, name: '釣り場B') }
    let(:name) { '釣り場a' }

    it 'nameが一致するレコードを返す' do
      expect(subject).to contain_exactly(fishing_spot1, fishing_spot2)
    end
  end
end
