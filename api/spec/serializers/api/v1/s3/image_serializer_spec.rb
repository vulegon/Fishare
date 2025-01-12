require 'rails_helper'

RSpec.describe ::Api::V1::S3::ImageSerializer, type: :serializer do
  describe '#as_json' do
    subject { described_class.new(parameter, prefix, bucket_name).as_json }

    let(:parameter) { ::Api::V1::S3::PresignedUrlParameter.new(ActionController::Parameters.new(params)) }
    let(:prefix) { 'supports/contact_images' }
    let(:bucket_name) { 'support_contact_image_bucket' }
    let(:random_uuid) { SecureRandom.uuid }

    before do
      allow(SecureRandom).to receive(:uuid).and_return(random_uuid)
      parameter.valid?
    end

    context "parameterのimage_formsが存在するとき" do
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

      it '整形されたデータが返ってくること' do
        expect(subject[:images].first[:s3_key]).to eq("supports/contact_images/#{random_uuid}/サンプル1.jpg")
        expect(subject[:images].first[:presigned_url]).to be_present
        expect(subject[:images].last[:s3_key]).to eq("supports/contact_images/#{random_uuid}/サンプル2.jpg")
        expect(subject[:images].last[:presigned_url]).to be_present
      end
    end

    context "parameterのimage_formsが存在しないとき" do
      let(:params) {
        {
          images: []
        }
      }

      it '整形されたデータが返ってくること' do
        expect(subject[:images]).to be_empty
      end
    end
  end
end
