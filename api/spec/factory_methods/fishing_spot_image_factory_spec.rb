require 'rails_helper'

RSpec.describe FishingSpotImageFactory do
  describe '#build' do
    subject { described_class.new.build(image_params, fishing_spot_id) }
    let(:image_params) {
      ::Api::V1::FishingSpots::ImageForm.new(
        s3_key: 'S3キー',
        file_name:  'ファイル名',
        content_type: 'ファイルの拡張子',
        file_size: 10,
        display_order: 1
      )
    }
    let(:fishing_spot_id) { SecureRandom.uuid }

    it '戻り値がFishingSpotImageであること' do
      expect(subject).to be_a(FishingSpotImage)
    end

    it '永続化されていないimageが返ってくること' do
      expect(subject).not_to be_persisted
    end

    it 'FishingSpotImageが期待値の内容であること' do
      expect(subject.id).to be_present
      expect(subject).to have_attributes(
        fishing_spot_id: fishing_spot_id,
        s3_key: image_params.s3_key,
        file_name: image_params.file_name,
        content_type: image_params.content_type,
        file_size: image_params.file_size
      )
    end
  end

  describe '#build_all' do
    subject { described_class.new.build_all(image_params, fishing_spot_id) }

    let(:image_form_1) {
      ::Api::V1::FishingSpots::ImageForm.new(
        s3_key: 'S3キー',
        file_name:  'ファイル名',
        content_type: 'ファイルの拡張子',
        file_size: 10,
        display_order: 1
      )
    }
    let(:image_form_2) {
      ::Api::V1::FishingSpots::ImageForm.new(
        s3_key: 'S3キー2',
        file_name:  'ファイル名2',
        content_type: 'ファイルの拡張子',
        file_size: 10,
        display_order: 2
      )
    }
    let(:image_params) {
      [image_form_1, image_form_2]
    }
    let(:fishing_spot_id) { SecureRandom.uuid }

    it '戻り値がFishingSpotImageの配列であること' do
      expect(subject).to all(be_a(FishingSpotImage))
    end

    describe '戻り値1つ目に関して' do
      it '永続化されていないimageが返ってくること' do
        expect(subject[0]).not_to be_persisted
      end

      it 'FishingSpotImageが期待値の内容であること' do
        expect(subject[0].id).to be_present
        expect(subject[0]).to have_attributes(
          fishing_spot_id: fishing_spot_id,
          s3_key: image_form_1.s3_key,
          file_name: image_form_1.file_name,
          content_type: image_form_1.content_type,
          file_size: image_form_1.file_size
        )
      end
    end

    describe '戻り値2つ目に関して' do
      it '永続化されていないimageが返ってくること' do
        expect(subject[1]).not_to be_persisted
      end

      it 'FishingSpotImageが期待値の内容であること' do
        expect(subject[1].id).to be_present
        expect(subject[1]).to have_attributes(
          fishing_spot_id: fishing_spot_id,
          s3_key: image_form_2.s3_key,
          file_name: image_form_2.file_name,
          content_type: image_form_2.content_type,
          file_size: image_form_2.file_size
        )
      end
    end
  end
end
