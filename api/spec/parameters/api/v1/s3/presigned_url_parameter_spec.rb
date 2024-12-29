
require 'rails_helper'

RSpec.describe ::Api::V1::S3::PresignedUrlParameter do
  describe '#valid?' do
    subject { parameter.valid? }
    let(:parameter) { described_class.new(ActionController::Parameters.new(params)) }

    context 'パラメータが有効の場合' do
      context 'imagesが設定されているとき' do
        let(:params) {
          {
            images: [
              {
                file_name: 'サンプル1.jpg',
                content_type: 'image/jpeg'
              },
              {
                file_name: 'サンプル2.jpg',
                content_type: 'image/jpeg'
              }
            ]
          }
        }

        it { is_expected.to be true }
      end

      context "imagesが設定されていないとき" do
        let(:params) {
          {
            images: []
          }
        }

        it { is_expected.to be true }
      end
    end

    context 'パラメータが無効の場合' do
      context 'imagesが誤りのとき' do
        context 'file_nameが誤りのとき' do
          context 'file_nameが設定されていないとき' do
            let(:params) {
              {
                images: [
                  {
                    content_type: 'image/jpeg'
                  }
                ]
              }
            }

            it {
              is_expected.to be false
              expect(parameter.errors[:images]).to a_string_including('ファイル名を入力してください')
            }
          end
        end

        context 'content_typeが誤りのとき' do
          context 'content_typeが設定されていないとき' do
            let(:params) {
              {
                images: [
                  {
                    file_name: 'サンプル.jpg'
                  }
                ]
              }
            }

            it {
              is_expected.to be false
              expect(parameter.errors[:images]).to a_string_including('拡張子を入力してください')
            }
          end
        end
      end
    end
  end

  describe '#image_forms' do
    subject { parameter.image_forms }

    let(:parameter) { described_class.new(ActionController::Parameters.new(params)) }

    context 'imagesが設定されているとき' do
      let(:params) {
        {
          images: [
            {
              file_name: 'サンプル1.jpg',
              content_type: 'image/jpeg'
            },
            {
              file_name: 'サンプル2.jpg',
              content_type: 'image/jpeg'
            }
          ]
        }
      }

      it { is_expected.to all(be_a(::Api::V1::S3::ImageForm)) }
    end

    context 'imagesが設定されていないとき' do
      let(:params) {
        {
          images: []
        }
      }

      it { is_expected.to be_empty }
    end
  end
end
