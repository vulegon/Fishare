require 'rails_helper'

RSpec.describe Api::V1::Supports::Contacts::CreateParameter do
  let_it_be(:contact_category) { create(:support_contact_category, name: 'other') }

  describe '#valid?' do
    subject { create_parameter.valid? }
    let(:create_parameter) { described_class.new(ActionController::Parameters.new(params)) }

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
                  file_name:  'ファイル名',
                  content_type: 'ファイルの拡張子',
                  file_size: 1000,
                  display_order: 1
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
      context 'nameが誤りのとき' do
        context 'nameが設定されていないとき' do
          let(:params) {
            {
              email: 'walkurepqrt@gmail.com',
              content: '1234567890',
              images: [],
              contact_category: 'other'
            }
          }

          it {
            expect(subject).to eq false
            expect(create_parameter.errors.full_messages).to include('名前を入力してください')
          }
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

          it {
            expect(subject).to eq false
            expect(create_parameter.errors.full_messages).to include('名前は2文字以上で入力してください')
          }
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

          it {
            expect(subject).to eq false
            expect(create_parameter.errors.full_messages).to include('名前は50文字以内で入力してください')
          }
        end
      end

      context 'contentが誤りのとき' do
        context 'contentが設定されていないとき' do
          let(:params) {
            {
              name: '山田太郎',
              email: 'walkurepqrt@gmail.com',
              images: [],
              contact_category: 'other'
            }
          }

          it {
            expect(subject).to eq false
            expect(create_parameter.errors.full_messages).to include('お問い合わせ内容を入力してください')
          }
        end

        context 'contentの文字数が10未満のとき' do
          let(:params) {
            {
              name: '山田太郎',
              email: 'walkurepqrt@gmail.com',
              content: '123456789',
              images: [],
              contact_category: 'other'
            }
          }

          it {
            expect(subject).to eq false
            expect(create_parameter.errors.full_messages).to include('お問い合わせ内容は10文字以上で入力してください')
          }
        end

        context 'contentの文字数が1000を超えるとき' do
          let(:params) {
            {
              name: '山田太郎',
              email: 'walkurepqrt@gmail.com',
              content: '1234567890' * 100 + '1',
              images: [],
              contact_category: 'other'
            }
          }

          it {
            expect(subject).to eq false
            expect(create_parameter.errors.full_messages).to include('お問い合わせ内容は1000文字以内で入力してください')
          }
        end
      end

      context 'emailが誤りのとき' do
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

          it {
            expect(subject).to eq false
            expect(create_parameter.errors.full_messages).to include('メールアドレスの形式が正しくありません')
          }
        end
      end

      context 'contact_categoryが誤りのとき' do
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

          it {
            expect(subject).to eq false
            expect(create_parameter.errors.full_messages).to include('お問い合わせ種類が見つかりません')
          }
        end
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
            file_name:  'ファイル名',
            content_type: 'ファイルの拡張子',
            file_size: 1000,
            display_order: 1
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
            file_name:  'ファイル名',
            content_type: 'ファイルの拡張子',
            file_size: 1000,
            display_order: 1
          }
        ]
      )
    }
  end
end
