require 'rails_helper'

RSpec.describe Api::V1::FishingSpots::CreateParameter do
  describe '#valid?' do
    subject { create_parameter.valid? }
    let(:create_parameter) { described_class.new(ActionController::Parameters.new(params)) }
    let!(:prefecture) { create(:prefecture) }
    let!(:fish) { create(:fish) }

    context 'パラメータが有効の場合' do
      context 'imagesが設定されている場合' do
        let(:params) {
          {
            name: '釣り場1',
            description: '1234567890',
            location: {
              prefecture: prefecture.name,
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
                file_size: 'ファイルサイズ'
              }
            ],
            fishes: [
              id: fish.id,
              name: fish.name
            ]
          }
        }

        it { expect(subject).to eq true }
      end

      context 'imagesが設定されていない場合' do
        let(:params) {
          {
            name: '釣り場1',
            description: '1234567890',
            location: {
              prefecture: prefecture.name,
              address: '東京都渋谷区',
              latitude: 35.658034,
              longitude: 139.701636
            },
            images: [],
            fishes: [
              id: fish.id,
              name: fish.name
            ]
          }
        }

        it { expect(subject).to eq true }
      end
    end

    context 'パラメータが無効の場合' do
      context 'nameが誤りのとき' do
        context 'nameが設定されていないとき' do
          let(:params) {
            {
              name: '',
              description: '1234567890',
              location: {
                prefecture: prefecture.name,
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                id: fish.id,
                name: fish.name
              ]
            }
          }

          it { expect(subject).to eq false }
        end

        context 'nameがnilのとき' do
          let(:params) {
            {
              description: '1234567890',
              location: {
                prefecture: prefecture.name,
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                id: fish.id,
                name: fish.name
              ]
            }
          }

          it { expect(subject).to eq false }
        end

        context 'nameの文字数が100文字以上のとき' do
          let(:params) {
            {
              name: '1234567890' * 10 + '1',
              description: '1234567890',
              location: {
                prefecture: prefecture.name,
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                id: fish.id,
                name: fish.name
              ]
            }
          }

          it { expect(subject).to eq false }
        end
      end

      context 'descriptionが誤りのとき' do
        context 'descriptionが設定されていないとき' do
          let(:params) {
            {
              name: '釣り場1',
              description: '',
              location: {
                prefecture: prefecture.name,
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                id: fish.id,
                name: fish.name
              ]
            }
          }

          it { expect(subject).to eq false }
        end

        context 'descriptionの文字数が10未満のとき' do
          let(:params) {
            {
              name: '釣り場1',
              description: '123456789',
              location: {
                prefecture: prefecture.name,
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                id: fish.id,
                name: fish.name
              ]
            }
          }

          it { expect(subject).to eq false }
        end

        context 'descriptionの文字数が1000を超えるとき' do
          let(:params) {
            {
              name: '釣り場1',
              description: '1234567890' * 100 + '1',
              location: {
                prefecture: prefecture.name,
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                id: fish.id,
                name: fish.name
              ]
            }
          }

          it { expect(subject).to eq false }
        end
      end

      context 'locationが誤りのとき' do
        context 'prefectureが誤りのとき' do
          context 'prefectureが設定されていないとき' do
            let(:params) {
              {
                name: '釣り場1',
                description: '123456789',
                location: {
                  address: '東京都渋谷区',
                  latitude: 35.658034,
                  longitude: 139.701636
                },
                images: [],
                fishes: [
                  id: fish.id,
                  name: fish.name
                ]
              }
            }

            it { expect(subject).to eq false }
          end

          context 'prefectureが存在しない都道府県のとき' do
            let(:params) {
              {
                name: '釣り場1',
                description: '123456789',
                location: {
                  prefecture: '存在しない都道府県',
                  address: '東京都渋谷区',
                  latitude: 35.658034,
                  longitude: 139.701636
                },
                images: [],
                fishes: [
                  id: fish.id,
                  name: fish.name
                ]
              }
            }

            it { expect(subject).to eq false }
          end
        end

        context 'addressが誤りのとき' do
          context 'addressが設定されていないとき' do
            let(:params) {
              {
                name: '釣り場1',
                description: '123456789',
                location: {
                  prefecture: prefecture.name,
                  address: '',
                  latitude: 35.658034,
                  longitude: 139.701636
                },
                images: [],
                fishes: [
                  id: fish.id,
                  name: fish.name
                ]
              }
            }

            it { expect(subject).to eq false }
          end

          context 'addressがnilのとき' do
            let(:params) {
              {
                name: '釣り場1',
                description: '123456789',
                location: {
                  prefecture: prefecture.name,
                  latitude: 35.658034,
                  longitude: 139.701636
                },
                images: [],
                fishes: [
                  id: fish.id,
                  name: fish.name
                ]
              }
            }

            it { expect(subject).to eq false }
          end
        end

        context 'latitudeが誤りのとき' do
          let(:params) {
              {
                name: '釣り場1',
                description: '123456789',
                location: {
                  prefecture: prefecture.name,
                  address: '東京都渋谷区',
                  longitude: 139.701636
                },
                images: [],
                fishes: [
                  id: fish.id,
                  name: fish.name
                ]
              }
            }

          it { expect(subject).to eq false }
        end

        context 'longitudeが誤りのとき' do
          let(:params) {
              {
                name: '釣り場1',
                description: '123456789',
                location: {
                  prefecture: prefecture.name,
                  address: '東京都渋谷区',
                  latitude: 35.658034
                },
                images: [],
                fishes: [
                  id: fish.id,
                  name: fish.name
                ]
              }
            }

          it { expect(subject).to eq false }
        end
      end

      context 'fishesが誤りのとき' do
        context 'fishesが設定されていないとき' do
          let(:params) {
              {
                name: '釣り場1',
                description: '123456789',
                location: {
                  prefecture: prefecture.name,
                  address: '東京都渋谷区',
                  latitude: 35.658034,
                  longitude: 139.701636
                },
                images: [],
                fishes: []
              }
            }

          it { expect(subject).to eq false }
        end

        context 'fishesが存在しない魚のとき' do
          let(:params) {
              {
                name: '釣り場1',
                description: '123456789',
                location: {
                  prefecture: prefecture.name,
                  address: '東京都渋谷区',
                  latitude: 35.658034,
                  longitude: 139.701636
                },
                images: [],
                fishes: [
                  {
                    id: SecureRandom.uuid,
                    name: '存在しない魚'
                  }
                ]
              }
            }

          it { expect(subject).to eq false }
        end
      end
    end
  end
end
