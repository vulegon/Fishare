require 'rails_helper'

RSpec.describe ::Api::V1::Supports::ContactImages::ImageSerializer, type: :serializer do
  describe '#as_json' do
    subject { described_class.new(parameter).as_json }
    let(:parameter) { ::Api::V1::Supports::ContactImages::GeneratePresignedUrlsParameter.new(ActionController::Parameters.new(params)) }
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
    let(:random_uuid) { SecureRandom.uuid }

    before do
      allow(SecureRandom).to receive(:uuid).and_return(random_uuid)
      parameter.valid?
    end

    it '整形されたデータが返ってくること' do
      expect(subject[:images].first[:s3_key]).to eq("supports/contact_images/#{random_uuid}/サンプル1.jpg")
      expect(subject[:images].first[:presigned_url]).to be_present
      expect(subject[:images].last[:s3_key]).to eq("supports/contact_images/#{random_uuid}/サンプル2.jpg")
      expect(subject[:images].last[:presigned_url]).to be_present
    end
  end
end
