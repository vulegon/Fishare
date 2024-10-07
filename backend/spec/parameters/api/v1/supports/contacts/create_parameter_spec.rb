require 'rails_helper'

RSpec.describe Api::V1::Supports::Contacts::CreateParameter do
  describe '#valid?' do
    subject { described_class.new(ActionController::Parameters.new(params)).valid? }

    context 'パラメータが有効の場合' do
      context 'パラメータが指定されている場合' do
        context 'imagesが設定されている場合' do
          let(:params) {
            {
              name: '山田太郎',
              email: 'walkurepqrt@gmail.com',
              content: '1234567890',
              images: [
                {
                  s3_key: 'S3キー',
                  s3_url: 'S3のURL',
                  file_name:  'ファイル名',
                  content_type: 'ファイルの拡張子',
                  file_size: 'ファイルサイズ'
                }
              ],
              contact_category: 'other'
            }
          }

          it { expect(subject).to eq true }
        end

        context 'imagesが設定されていない場合' do
          let(:params) {
            {
              name: '山田太郎',
              email: 'walkurepqrt@gmail.com',
              content: '1234567890',
              images: [],
              contact_category: 'other'
            }
          }

          it { expect(subject).to eq true }
        end
      end
    end

    context 'パラメータが無効の場合' do
      context 'nameが設定されていないとき' do
        let(:params) {
          {
            name: '',
            email: 'walkurepqrt@gmail.com',
            content: '1234567890',
            images: [],
            contact_category: 'other'
          }
        }

        it { expect(subject).to eq false }
      end

      context 'contentが設定されていないとき' do
        let(:params) {
          {
            name: '山田太郎',
            email: 'walkurepqrt@gmail.com',
            content: '',
            images: [],
            contact_category: 'other'
          }
        }

        it { expect(subject).to eq false }
      end

      context 'メールアドレスのフォーマットが正しくないとき' do
        let(:params) {
          {
            name: '山田太郎',
            email: 'walkurepqrt',
            content: '1234567890',
            images: [],
            contact_category: 'other'
          }
        }

        it { expect(subject).to eq false }
      end

      context 'nameの文字数が2文字未満のとき' do
        let(:params) {
          {
            name: '山',
            email: 'walkurepqrt@gmail.com',
            content: '1234567890',
            images: [],
            contact_category: 'other'
          }
        }

        it { expect(subject).to eq false }
      end

      context 'nameの文字数が50文字を超えるとき' do
        let(:params) {
          {
            name: '1234567890' * 5 + '1',
            email: 'walkurepqrt@gmail.com',
            content: '1234567890',
            images: [],
            contact_category: 'other'
          }
        }

        it { expect(subject).to eq false }
      end

      context 'contact_categoryが存在しない種類のとき' do
        let(:params) {
          {
            name: '1234567890',
            email: 'walkurepqrt@gmail.com',
            content: '1234567890',
            images: [],
            contact_category: 'invalid'
          }
        }

        it { expect(subject).to eq false }
      end
    end
  end

  describe '#images' do
    subject { described_class.new(ActionController::Parameters.new(params)).images }
    let(:params) {
      {
        name: '山田太郎',
        email: 'walkurepqrt@gmail.com',
        content: '1234567890',
        images: [
          {
            s3_key: 'S3キー',
            s3_url: 'S3のURL',
            file_name:  'ファイル名',
            content_type: 'ファイルの拡張子',
            file_size: 'ファイルサイズ'
          }
        ],
        contact_category: 'other'
      }
    }

    it {
      expect(subject).to eq(
        [
          {
            s3_key: 'S3キー',
            s3_url: 'S3のURL',
            file_name:  'ファイル名',
            content_type: 'ファイルの拡張子',
            file_size: 'ファイルサイズ'
          }
        ]
      )
    }
  end
end
