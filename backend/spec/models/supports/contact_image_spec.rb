# == Schema Information
#
# Table name: support_contact_images
#
#  id                                 :uuid             not null, primary key
#  content_type(ファイルの拡張子)     :string           not null
#  display_order(表示順)              :integer          not null
#  file_name(ファイル名)              :string           not null
#  file_size(ファイルサイズ)          :integer          not null
#  s3_key(S3キー)                     :string           not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  support_contact_id(お問い合わせID) :uuid             not null
#
# Indexes
#
#  index_support_contact_images_on_contact_id_and_display_order  (support_contact_id,display_order) UNIQUE
#  index_support_contact_images_on_s3_key_unique                 (s3_key) UNIQUE
#  index_support_contact_images_on_support_contact_id            (support_contact_id)
#
# Foreign Keys
#
#  fk_rails_...  (support_contact_id => support_contacts.id)
#
require 'rails_helper'

RSpec.describe ::Supports::ContactImage, type: :model do
  let_it_be(:support_contact_category) { create(:support_contact_category) }
  let_it_be(:support_contact) { create(:support_contact, support_contact_category_id: support_contact_category.id) }

  describe '.valid?' do
    subject { contact_image.valid? }

    let(:contact_image) {
      build(
        :support_contact_image,
        support_contact_id: support_contact.id,
        s3_key: s3_key,
        file_name: file_name,
        content_type: content_type,
        file_size: file_size,
        display_order: display_order
      )
    }
    let(:s3_key) { 's3_key/contact_image.jpg' }
    let(:file_name) { 'contact_image.jpg' }
    let(:content_type) { 'image/jpg' }
    let(:file_size) { 1024 }
    let(:display_order) { 1 }

    shared_examples '有効な場合の検証' do
      it 'trueを返すこと' do
        expect(subject).to eq true
      end
    end

    shared_examples '無効な場合の検証' do
      it 'falseを返すこと' do
        expect(subject).to eq false
      end
    end

    describe 's3_key' do
      context 's3_keyが設定されている場合' do
        it_behaves_like '有効な場合の検証'
      end

      context 's3_keyがnilの場合' do
        let(:s3_key) { nil }

        it_behaves_like '無効な場合の検証'
      end

      context 's3_keyが空文字の場合' do
        let(:s3_key) { '' }

        it_behaves_like '無効な場合の検証'
      end

      context 's3_keyが重複している場合' do
        before {
          create(
            :support_contact_image,
            support_contact_id: support_contact.id,
            s3_key: s3_key,
            file_name: 'contact_image2.jpg',
            content_type: 'image/jpg',
            file_size: 2048,
            display_order: 2
          )
        }

        it_behaves_like '無効な場合の検証'
      end
    end

    describe 'file_name' do
      context 'file_nameが設定されている場合' do
        it_behaves_like '有効な場合の検証'
      end

      context 'file_nameがnilの場合' do
        let(:file_name) { nil }

        it_behaves_like '無効な場合の検証'
      end

      context 'file_nameが空文字の場合' do
        let(:file_name) { '' }

        it_behaves_like '無効な場合の検証'
      end
    end

    describe 'content_type' do
      context 'content_typeが設定されている場合' do
        it_behaves_like '有効な場合の検証'
      end

      context 'content_typeがnilの場合' do
        let(:content_type) { nil }

        it_behaves_like '無効な場合の検証'
      end

      context 'content_typeが空文字の場合' do
        let(:content_type) { '' }

        it_behaves_like '無効な場合の検証'
      end
    end

    describe 'file_size' do
      context 'file_sizeが設定されている場合' do
        it_behaves_like '有効な場合の検証'
      end

      context 'file_sizeがnilの場合' do
        let(:file_size) { nil }

        it_behaves_like '無効な場合の検証'
      end

      context 'file_sizeが0未満の場合' do
        let(:file_size) { -1 }

        it_behaves_like '無効な場合の検証'
      end

      context 'file_sizeが0の場合' do
        let(:file_size) { 0 }

        it_behaves_like '有効な場合の検証'
      end
    end

    describe 'display_order' do
      context 'display_orderが設定されている場合' do
        it_behaves_like '有効な場合の検証'
      end

      context 'display_orderがnilの場合' do
        let(:display_order) { nil }

        it_behaves_like '無効な場合の検証'
      end

      context 'display_orderが0未満の場合' do
        let(:display_order) { -1 }

        it_behaves_like '無効な場合の検証'
      end

      context 'display_orderが0の場合' do
        let(:display_order) { 0 }

        it_behaves_like '有効な場合の検証'
      end

      context 'support_contact_id と display_order の組み合わせが重複している場合' do
        before {
          create(
            :support_contact_image,
            support_contact_id: support_contact.id,
            s3_key: 's3_key/contact_image2.jpg',
            file_name: 'contact_image2.jpg',
            content_type: 'image/jpg',
            file_size: 2048,
            display_order: display_order
          )
        }

        it_behaves_like '無効な場合の検証'
      end
    end
  end
end
