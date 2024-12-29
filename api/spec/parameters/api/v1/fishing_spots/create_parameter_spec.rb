require 'rails_helper'

RSpec.describe Api::V1::FishingSpots::CreateParameter do
  let_it_be(:prefecture) { create(:prefecture) }
  let_it_be(:fish_1) { create(:fish, name: '魚1') }
  let_it_be(:fish_2) { create(:fish, name: '魚2') }

  describe '#valid?' do
    subject { create_parameter.valid? }
    let(:create_parameter) { described_class.new(ActionController::Parameters.new(params)) }

    context 'パラメータが有効の場合' do
      context 'imagesが設定されている場合' do
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
                file_size: 10,
                display_order: 1
              }
            ],
            fishes: [
              { id: fish_1.id, name: fish_1.name },
              { id: fish_2.id, name: fish_2.name }
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
              prefecture: { id: prefecture.id, name: prefecture.name },
              address: '東京都渋谷区',
              latitude: 35.658034,
              longitude: 139.701636
            },
            images: [],
            fishes: [
              { id: fish_1.id, name: fish_1.name },
              { id: fish_2.id, name: fish_2.name }
            ]
          }
        }

        it { expect(subject).to eq true }
      end
    end

    shared_examples 'パラメータが無効の場合の検証' do |error_message|
      it 'falseが返ること' do
        expect(subject).to eq false
      end

      it 'エラーメッセージが設定されていること' do
        subject
        expect(create_parameter.errors.full_messages).to include(error_message)
      end
    end

    context 'パラメータが無効の場合' do
      context 'nameが設定されていない場合' do
        context 'nameが空文字の場合' do
          let(:params) {
            {
              name: '',
              description: '1234567890',
              location: {
                prefecture: { id: prefecture.id, name: prefecture.name },
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                { id: fish_1.id, name: fish_1.name },
                { id: fish_2.id, name: fish_2.name }
              ]
            }
          }

          include_examples 'パラメータが無効の場合の検証', '釣り場名称を入力してください'
        end

        context 'nameがnilの場合' do
          let(:params) {
            {
              description: '1234567890',
              location: {
                prefecture: { id: prefecture.id, name: prefecture.name },
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                { id: fish_1.id, name: fish_1.name },
              ]
            }
          }

          include_examples 'パラメータが無効の場合の検証', '釣り場名称を入力してください'
        end
      end

      context 'descriptionが設定されていない場合' do
        context 'descriptionがnilの場合' do
          let(:params) {
            {
              name: 'サンプル',
              location: {
                prefecture: { id: prefecture.id, name: prefecture.name },
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                { id: fish_1.id, name: fish_1.name },
                { id: fish_2.id, name: fish_2.name }
              ]
            }
          }

          it_behaves_like 'パラメータが無効の場合の検証', '釣り場説明を入力してください'
        end

        context 'descriptionが10文字未満の場合' do
          let(:params) {
            {
              name: 'サンプル',
              description: '123456789',
              location: {
                prefecture: { id: prefecture.id, name: prefecture.name },
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                { id: fish_1.id, name: fish_1.name },
                { id: fish_2.id, name: fish_2.name }
              ]
            }
          }

          it_behaves_like 'パラメータが無効の場合の検証', '釣り場説明は10文字以上で入力してください'
        end

        context 'descriptionが10文字未満の場合' do
          let(:params) {
            {
              name: 'サンプル',
              description: '1234567890' * 100 + '1',
              location: {
                prefecture: { id: prefecture.id, name: prefecture.name },
                address: '東京都渋谷区',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                { id: fish_1.id, name: fish_1.name },
                { id: fish_2.id, name: fish_2.name }
              ]
            }
          }

          it_behaves_like 'パラメータが無効の場合の検証', '釣り場説明は1000文字以内で入力してください'
        end
      end

      context 'locationが誤りの場合' do
        context 'prefectureが誤りの場合' do
          context 'prefectureが存在しないIDの場合' do
            let(:params) {
              {
                name: 'サンプル',
                description: '1234567890',
                location: {
                  prefecture: { id: SecureRandom.uuid, name: '存在しない都道府県' },
                  address: '東京都渋谷区',
                  latitude: 35.658034,
                  longitude: 139.701636
                },
                images: [],
                fishes: [
                  { id: fish_1.id, name: fish_1.name },
                ]
              }
            }

            it_behaves_like 'パラメータが無効の場合の検証', '釣り場住所の都道府県が見つかりません'
          end
        end

        context 'addressが誤りの場合' do
          let(:params) {
            {
              name: 'サンプル',
              description: '1234567890',
              location: {
                prefecture: { id: prefecture.id, name: prefecture.name },
                address: '',
                latitude: 35.658034,
                longitude: 139.701636
              },
              images: [],
              fishes: [
                { id: fish_1.id, name: fish_1.name },
              ]
            }
          }

          it_behaves_like 'パラメータが無効の場合の検証', '釣り場住所の住所が未入力です'
        end

        context 'latitudeが誤りの場合' do
          let(:params) {
            {
              name: 'サンプル',
              description: '1234567890',
              location: {
                prefecture:  { id: prefecture.id, name: prefecture.name },
                address: '東京都渋谷区',
                longitude: 139.701636
              },
              images: [],
              fishes: [
                { id: fish_1.id, name: fish_1.name },
              ]
            }
          }

          it_behaves_like 'パラメータが無効の場合の検証', '釣り場住所の緯度が見つかりません'
        end

        context 'longitudeが誤りの場合' do
          let(:params) {
            {
              name: 'サンプル',
              description: '1234567890',
              location: {
                prefecture: { id: prefecture.id, name: prefecture.name },
                address: '東京都渋谷区',
                latitude: 35.658034
              },
              images: [],
              fishes: [
                { id: fish_1.id, name: fish_1.name },
              ]
            }
          }

          it_behaves_like 'パラメータが無効の場合の検証', '釣り場住所の経度が見つかりません'
        end

        context 'fishesが誤りの場合' do
          context 'fishesが存在しないIDの場合' do
            let(:params) {
              {
                name: 'サンプル',
                description: '1234567890',
                location: {
                  prefecture: { id: prefecture.id, name: prefecture.name },
                  address: '東京都渋谷区',
                  latitude: 35.658034,
                  longitude: 139.701636
                },
                images: [],
                fishes: [
                  { id: 111, name: fish_1.name },
                ]
              }
            }

            it_behaves_like 'パラメータが無効の場合の検証', '魚種が指定されていないか、存在しない魚が含まれています'
          end

          context 'fishesが空の場合' do
            let(:params) {
              {
                name: 'サンプル',
                description: '1234567890',
                location: {
                  prefecture: { id: prefecture.id, name: prefecture.name },
                  address: '東京都渋谷区',
                  latitude: 35.658034,
                  longitude: 139.701636
                },
                images: [],
                fishes: []
              }
            }

            it_behaves_like 'パラメータが無効の場合の検証', '魚種が指定されていないか、存在しない魚が含まれています'
          end
        end
      end

      context 'imagesが誤りの場合' do
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
                file_name:  'ファイル名',
                content_type: 'ファイルの拡張子',
                file_size: 10,
                display_order: 1
              }
            ],
            fishes: [
              { id: fish_1.id, name: fish_1.name },
              { id: fish_2.id, name: fish_2.name }
            ]
          }
        }

        it {
          expect(subject).to eq false
          expect(create_parameter.errors[:images]).to a_string_including('s3キーを入力してください')
        }
      end
    end
  end
end
