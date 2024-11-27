# == Schema Information
#
# Table name: fishing_spot_images
#
#  id                             :uuid             not null, primary key
#  content_type(ファイルの拡張子) :string           not null
#  display_order(表示順)          :integer          not null
#  file_name(ファイル名)          :string           not null
#  file_size(ファイルサイズ)      :integer          not null
#  s3_key(S3キー)                 :string           not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  fishing_spot_id(釣り場ID)      :uuid             not null
#
# Indexes
#
#  index_fishing_spot_images_on_fishing_spot_id                   (fishing_spot_id)
#  index_fishing_spot_images_on_s3_key_unique                     (s3_key) UNIQUE
#  index_fishing_spot_images_on_spot_id_and_display_order_unique  (fishing_spot_id,display_order) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (fishing_spot_id => fishing_spots.id)
#
require 'rails_helper'

RSpec.describe FishingSpotImage, type: :model do
  describe '.valid?' do
    subject { fishing_spot_image.valid? }
    let!(:fishing_spot) { create(:fishing_spot) }
    let(:fishing_spot_image) {
      build(
        :fishing_spot_image,
        fishing_spot_id: fishing_spot.id,
        s3_key: s3_key,
        file_name: file_name,
        content_type: content_type,
        file_size: file_size,
        display_order: display_order
      )
    }
    let(:s3_key) { 'fishing_spots/1' }
    let(:file_name) { 'fishing_spot.jpg' }
    let(:content_type) { 'image/jpeg' }
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
      context 'nilの場合' do
        let(:s3_key) { nil }
        it_behaves_like '無効な場合の検証'
      end

      context '空文字の場合' do
        let(:s3_key) { '' }
        it_behaves_like '無効な場合の検証'
      end

      context '重複した場合' do
        before { create(:fishing_spot_image, fishing_spot_id: fishing_spot.id, s3_key: s3_key) }
        it_behaves_like '無効な場合の検証'
      end
    end

    describe 'file_name' do
      context 'nilの場合' do
        let(:file_name) { nil }
        it_behaves_like '無効な場合の検証'
      end

      context '空文字の場合' do
        let(:file_name) { '' }
        it_behaves_like '無効な場合の検証'
      end
    end

    describe 'content_type' do
      context 'nilの場合' do
        let(:content_type) { nil }
        it_behaves_like '無効な場合の検証'
      end

      context '空文字の場合' do
        let(:content_type) { '' }
        it_behaves_like '無効な場合の検証'
      end
    end

    describe 'file_size' do
      context 'nilの場合' do
        let(:file_size) { nil }
        it_behaves_like '無効な場合の検証'
      end

      context '0の場合' do
        let(:file_size) { 0 }
        it_behaves_like '有効な場合の検証'
      end

      context 'マイナスの場合' do
        let(:file_size) { -1 }
        it_behaves_like '無効な場合の検証'
      end
    end

    describe 'display_order' do
      context 'nilの場合' do
        let(:display_order) { nil }
        it_behaves_like '無効な場合の検証'
      end

      context '0の場合' do
        let(:display_order) { 0 }
        it_behaves_like '有効な場合の検証'
      end

      context 'マイナスの場合' do
        let(:display_order) { -1 }
        it_behaves_like '無効な場合の検証'
      end

      context '重複した場合' do
        before { create(:fishing_spot_image, fishing_spot_id: fishing_spot.id, display_order: display_order) }
        it_behaves_like '無効な場合の検証'
      end
    end
  end
end
