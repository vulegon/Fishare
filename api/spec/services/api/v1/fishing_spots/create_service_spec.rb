require 'rails_helper'

RSpec.describe ::Api::V1::FishingSpots::CreateService do
  let_it_be(:prefecture) { create(:prefecture) }
  let_it_be(:fish_1) { create(:fish, name: 'カサゴ') }
  let_it_be(:fish_2) { create(:fish, name: 'アジ') }

  describe '.create!' do
    subject { described_class.create!(create_params) }
    let(:create_params) { ::Api::V1::FishingSpots::CreateParameter.new(ActionController::Parameters.new(params)) }

    context "imagesが設定されている場合" do
      let(:params) {
        {
          name: '釣り場1',
          description: '1234567890',
          location: {
            prefecture: { id: prefecture.id, name: prefecture.name },
            address: '東京都渋谷区',
            latitude: 35.658034,
            longitude: 139.701636
          },
          images: [
            {
              s3_key: 'S3キー',
              file_name:  'ファイル名',
              content_type: 'ファイルの拡張子',
              file_size: 100,
              display_order: 1
            }
          ],
          fishes: [
            {
              id: fish_1.id,
              name: fish_1.name
            },
            {
              id: fish_2.id,
              name: fish_2.name
            }
          ]
        }
      }

      before do
        create_params.valid?
      end

      it 'fishing_spotが永続化されること' do
        expect(subject).to be_persisted
      end

      it 'fishing_spotが期待値の内容であること' do
        expect(subject).to have_attributes(
          name: params[:name],
          description: params[:description]
        )
      end

      it 'fishing_spot_imagesが永続化されること' do
        expect(subject.images).to all(be_persisted)
      end

      it 'fishing_spot_imagesが期待値の内容であること' do
        fishing_spot = subject
        expect(fishing_spot.images).to contain_exactly(
          have_attributes(
            fishing_spot_id: fishing_spot.id,
            s3_key: 'S3キー',
            file_name: 'ファイル名',
            content_type: 'ファイルの拡張子',
            file_size: 100,
            display_order: 1
          )
        )
      end

      it 'fishing_spot_locationsが永続化されること' do
        expect(subject.locations).to all(be_persisted)
      end

      it 'fishing_spot_locationsが期待値の内容であること' do
        expect(subject.locations).to contain_exactly(
          have_attributes(
            fishing_spot_id: subject.id,
            address: '東京都渋谷区',
            latitude: 35.658034,
            longitude: 139.701636,
            prefecture_id: prefecture.id
          )
        )
      end

      it 'fishing_spot_fishesが永続化されること' do
        expect(subject.fishes).to all(be_persisted)
      end

      it 'fishing_spot_fishesが期待値の内容であること' do
        expect(subject.fishes).to contain_exactly(
          have_attributes(
            id: fish_1.id,
            name: fish_1.name
          ),
          have_attributes(
            id: fish_2.id,
            name: fish_2.name
          )
        )
      end
    end

    context "imagesが設定されていない場合" do
      let(:params) {
        {
          name: '釣り場1',
          description: '1234567890',
          location: {
            prefecture: { id: prefecture.id, name: prefecture.name },
            address: '東京都渋谷区',
            latitude: 35.658034,
            longitude: 139.701636
          },
          images: [],
          fishes: [
            {
              id: fish_1.id,
              name: fish_1.name
            },
            {
              id: fish_2.id,
              name: fish_2.name
            }
          ]
        }
      }

      it 'fishing_spotが永続化されること' do
        expect(subject).to be_persisted
      end

      it 'fishing_spotが期待値の内容であること' do
        expect(subject).to have_attributes(
          name: params[:name],
          description: params[:description]
        )
      end

      it 'fishing_spot_imagesが存在しないこと' do
        expect(subject.images).to be_empty
      end

      it 'fishing_spot_locationsが永続化されること' do
        expect(subject.locations).to all(be_persisted)
      end

      it 'fishing_spot_locationsが期待値の内容であること' do
        expect(subject.locations).to contain_exactly(
          have_attributes(
            fishing_spot_id: subject.id,
            address: '東京都渋谷区',
            latitude: 35.658034,
            longitude: 139.701636,
            prefecture_id: prefecture.id
          )
        )
      end

      it 'fishing_spot_fishesが永続化されること' do
        expect(subject.fishes).to all(be_persisted)
      end

      it 'fishing_spot_fishesが期待値の内容であること' do
        expect(subject.fishes).to contain_exactly(
          have_attributes(
            id: fish_1.id,
            name: fish_1.name
          ),
          have_attributes(
            id: fish_2.id,
            name: fish_2.name
          )
        )
      end
    end
  end
end
