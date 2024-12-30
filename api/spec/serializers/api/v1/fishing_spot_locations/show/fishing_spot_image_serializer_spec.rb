require 'rails_helper'

RSpec.describe ::Api::V1::FishingSpotLocations::Show::FishingSpotImageSerializer, type: :serializer do
  let_it_be(:fishing_spot_image) { create(:fishing_spot_image) }

  describe '#as_json' do
    subject { described_class.new(fishing_spot_image).as_json }

    let(:s3_helper) { ::LibAws::S3Helper.new }
    let(:presigned_url) { s3_helper.get_presigned_url(bucket_name: Rails.configuration.x.lib_aws.s3[:fishing_spot_image_bucket], key: fishing_spot_image.s3_key, expires_in: 3600) }

    it '整形されたfishing_spot_fishe_imageが返ってくること' do
      expect(subject).to eq(
        id: fishing_spot_image.id,
        s3_key: fishing_spot_image.s3_key,
        file_name: fishing_spot_image.file_name,
        content_type: fishing_spot_image.content_type,
        presigned_url: presigned_url
      )
    end
  end
end
