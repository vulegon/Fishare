
require 'rails_helper'

RSpec.describe Api::V1::S3::ImageForm do
  describe '#valid?' do
    subject { parameter.valid? }
    let(:parameter) { described_class.new(params) }

    context 'パラメータが有効の場合' do
      let(:params) { { file_name: 'サンプル.jpg', content_type: 'image/jpeg' } }

      it { is_expected.to be true }
    end

    context 'パラメータが無効の場合' do
      context 'file_nameが誤りのとき' do
        context 'file_nameが設定されていないとき' do
          let(:params) { { content_type: 'image/jpeg' } }

          it {
            is_expected.to be false
            expect(parameter.errors.full_messages).to include('ファイル名を入力してください')
          }
        end
      end

      context 'content_typeが誤りのとき' do
        context 'content_typeが設定されていないとき' do
          let(:params) { { file_name: 'サンプル.jpg' } }

          it {
            is_expected.to be false
            expect(parameter.errors.full_messages).to include('拡張子を入力してください')
          }
        end
      end
    end
  end
end
