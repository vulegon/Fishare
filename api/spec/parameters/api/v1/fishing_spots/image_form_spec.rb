require 'rails_helper'

RSpec.describe Api::V1::FishingSpots::ImageForm do
  describe '#valid?' do
    subject { image_form.valid? }

    let(:image_form) { described_class.new(params) }

    context 'パラメータが有効の場合' do
      let(:params) {
        {
          s3_key: 'S3キー',
          file_name:  'ファイル名',
          content_type: 'ファイルの拡張子',
          file_size: 10,
          display_order: 1
        }
      }

      it { is_expected.to be true }
    end

    context 'パラメータが無効の場合' do
      context 's3_keyが誤りのとき' do
        context 's3_keyが設定されていないとき' do
          let(:params) {
            {
              file_name:  'ファイル名',
              content_type: 'ファイルの拡張子',
              file_size: 10,
              display_order: 1
            }
          }

          it {
            is_expected.to be false
          }
        end
      end

      context 'file_nameが誤りのとき' do
        context 'file_nameが設定されていないとき' do
          let(:params) {
            {
              s3_key: 'S3キー',
              content_type: 'ファイルの拡張子',
              file_size: 10,
              display_order: 1
            }
          }

          it {
            is_expected.to be false
          }
        end
      end

      context 'content_typeが誤りのとき' do
        context 'content_typeが設定されていないとき' do
          let(:params) {
            {
              s3_key: 'S3キー',
              file_name:  'ファイル名',
              file_size: 10,
              display_order: 1
            }
          }
        end
      end

      context 'file_sizeが誤りのとき' do
        context 'file_sizeが設定されていないとき' do
          let(:params) {
            {
              s3_key: 'S3キー',
              file_name:  'ファイル名',
              content_type: 'ファイルの拡張子',
              display_order: 1
            }
          }

          it {
            is_expected.to be false
          }
        end
      end

      context 'display_orderが誤りのとき' do
        context 'display_orderが設定されていないとき' do
          let(:params) {
            {
              s3_key: 'S3キー',
              file_name:  'ファイル名',
              content_type: 'ファイルの拡張子',
              file_size: 10,
            }
          }

          it {
            is_expected.to be false
          }
        end
      end
    end
  end
end
