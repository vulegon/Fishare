# == Schema Information
#
# Table name: fish
#
#  id                    :uuid             not null, primary key
#  display_order(表示順) :integer          not null
#  name(魚の名前)        :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_fish_on_display_order  (display_order)
#  index_fish_on_name_unique    (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Fish, type: :model do
  describe 'validation' do
    subject { fish.valid? }

    shared_examples '無効な場合の検証' do |error_message|
      it 'falseを返すこと' do
        is_expected.to eq false
      end

      it '適切なエラーメッセージを返すこと' do
        subject
        expect(fish.errors.full_messages).to include(error_message)
      end
    end

    context 'nameが誤りのとき' do
      context 'nameがnilのとき' do
        let(:fish) { build(:fish, name: nil) }
        it_behaves_like '無効な場合の検証', '魚の名前を入力してください'
      end

      context 'nameが空文字のとき' do
        let(:fish) { build(:fish, name: '') }
        it_behaves_like '無効な場合の検証', '魚の名前を入力してください'
      end
    end
  end
end
