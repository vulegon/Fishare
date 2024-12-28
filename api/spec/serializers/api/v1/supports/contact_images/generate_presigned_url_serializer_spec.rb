require 'rails_helper'

RSpec.describe ::Api::V1::Supports::ContactImages::GeneratePresignedUrlSerializer, type: :serializer do
  describe '#as_json' do
    subject { described_class.new(image_form).as_json }
    let(:image_form) { ::Api::V1::Supports::ContactImages::ImageForm.new(params) }
    let(:params) {{ file_name: 'test.jpg', content_type: 'image/jpeg' }}
    let(:random_uuid) { SecureRandom.uuid }
    before do
      allow(SecureRandom).to receive(:uuid).and_return(random_uuid)
    end

    it '整形されたデータが返ってくること' do
      expect(subject[:s3_key]).to eq("supports/contact_images/#{random_uuid}/test.jpg")
      expect(subject[:presigned_url]).to a_string_including("supports/contact_images/#{random_uuid}/test.jpg")
    end
  end
end
