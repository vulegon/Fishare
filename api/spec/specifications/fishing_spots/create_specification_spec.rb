require 'rails_helper'

RSpec.describe FishingSpots::CreateSpecification do
  describe '.satisfied_by?' do
    subject { described_class.new.satisfied_by?(user) }

    context '管理者の場合' do
      let!(:user) { create(:user, :admin) }

      it { is_expected.to eq(true) }
    end

    context '管理者以外の場合' do
      let(:user) { build(:user) }

      it { is_expected.to eq(false) }
    end
  end

  describe '.unsatisfied_reason' do
    subject { described_class.new.unsatisfied_reason }

    it { is_expected.to eq('管理者以外は釣り場を作成できません') }
  end
end
