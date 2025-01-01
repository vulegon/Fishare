require 'rails_helper'

RSpec.describe Api::V1::FishingSpots::SearchParameter do
  let_it_be(:prefecture) { create(:prefecture) }
  let_it_be(:fish_1) { create(:fish, name: '魚1') }
  let_it_be(:fish_2) { create(:fish, name: '魚2') }

  describe '#valid?' do
    subject { search_parameter.valid? }

    let(:search_parameter) { described_class.new(ActionController::Parameters.new(params)) }

    context 'パラメータが有効の場合' do
      context 'パラメータがすべて指定されている場合' do
        let(:params) {
          {
            name: '釣り場1',
            prefecture_id: prefecture.id,
            fishes: [
              { id: fish_1.id },
              { id: fish_2.id }
            ],
            offset: 0,
            limit: 10
          }
        }

        it { expect(subject).to eq true }
      end

      context 'パラメータが指定されていない場合' do
        let(:params) { {} }

        it { expect(subject).to eq true }
      end
    end

    context 'パラメータが無効の場合' do
      context 'prefecture_idが存在しないIDの場合' do
        let(:params) {
          {
            name: '釣り場1',
            prefecture_id: '1',
            fishes: [
              { id: fish_1.id },
              { id: fish_2.id }
            ]
          }
        }

        it {
          expect(subject).to eq false
          expect(search_parameter.errors.full_messages).to include('都道府県が見つかりません')
        }
      end

      context 'fishesが存在しないIDの場合' do
        let(:params) {
          {
            name: '釣り場1',
            prefecture_id: prefecture.id,
            fishes: [
              { id: '1' },
              { id: '2' }
            ]
          }
        }

        it {
          expect(subject).to eq false
          expect(search_parameter.errors.full_messages).to include('魚種が見つかりません')
        }
      end
    end
  end
end
