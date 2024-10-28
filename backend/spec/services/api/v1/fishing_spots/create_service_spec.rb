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
              prefecture_name: prefecture.name,
              address: '東京都渋谷区',
              latitude: 35.658034,
              longitude: 139.701636
            },
            images: [
              {
                s3_key: 'S3キー',
                s3_url: 'S3のURL',
                file_name:  'ファイル名',
                content_type: 'ファイルの拡張子',
                file_size: 100
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

      it '永続化されていること' do
        subject
        fishing_spot = ::FishingSpot.find_by(name: params[:name])
        expect(fishing_spot).to have_attributes(
          name: params[:name],
          description: params[:description]
        )
        expect(fishing_spot).to be_persisted
        expect(fishing_spot.images).to contain_exactly(
          have_attributes(
            fishing_spot_id: fishing_spot.id,
            s3_key: 'S3キー',
            s3_url: 'S3のURL',
            file_name: 'ファイル名',
            content_type: 'ファイルの拡張子',
            file_size: 100
          )
        )
        expect(fishing_spot.images).to all(be_persisted)
        expect(fishing_spot.locations).to contain_exactly(
          have_attributes(
            address: '東京都渋谷区',
            latitude: 35.658034,
            longitude: 139.701636,
            fishing_spot_id: fishing_spot.id,
            prefecture_id: prefecture.id
          )
        )
        expect(fishing_spot.locations).to all(be_persisted)
        expect(fishing_spot.fishes).to contain_exactly(
          have_attributes(
            id: fish_1.id,
            name: fish_1.name
          ),
          have_attributes(
            id: fish_2.id,
            name: fish_2.name
          )
        )
        expect(fishing_spot.fishes).to all(be_persisted)
      end
    end
  end
end
