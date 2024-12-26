require 'rails_helper'

RSpec.describe LibAws::S3Helper do
  describe '#initialize' do
    subject {  described_class.new }

    it 'Aws::S3::Resourceのインスタンスであること' do
      expect(subject.instance_variable_get(:@s3_resource)).to be_a(Aws::S3::Resource)
    end
  end

  describe '#put_presigned_url' do
    subject { described_class.new.put_presigned_url(bucket_name: bucket_name, key: key, expires_in: expires_in, content_type: content_type) }

    context 'expires_inが指定されていない場合' do
      let(:bucket_name) { 'test-bucket' }
      let(:key) { 'test-key' }
      let(:expires_in) { nil }
      let(:content_type) { 'image/jpeg' }

      it 'デフォルトで900秒のPresigned URLを取得すること' do
        expect(subject).to include("https://#{bucket_name}.s3.#{Rails.configuration.x.lib_aws.region}.amazonaws.com/#{key}")
      end
    end

    context 'expires_inが指定されている場合' do
      let(:bucket_name) { 'test-bucket' }
      let(:key) { 'test-key' }
      let(:expires_in) { 60 }
      let(:content_type) { 'image/jpeg' }

      it '指定した秒数のPresigned URLを取得すること' do
        expect(subject).to include("https://#{bucket_name}.s3.#{Rails.configuration.x.lib_aws.region}.amazonaws.com/#{key}")
      end
    end
  end


  describe '#get_presigned_url' do
    subject { described_class.new.get_presigned_url(bucket_name: bucket_name, key: key, expires_in: expires_in) }

    context 'expires_inが指定されていない場合' do
      let(:bucket_name) { 'test-bucket' }
      let(:key) { 'test-key' }
      let(:expires_in) { nil }

      it 'デフォルトで3600秒のPresigned URLを取得すること' do
        expect(subject).to include("https://#{bucket_name}.s3.#{Rails.configuration.x.lib_aws.region}.amazonaws.com/#{key}")
      end
    end

    context 'expires_inが指定されている場合' do
      let(:bucket_name) { 'test-bucket' }
      let(:key) { 'test-key' }
      let(:expires_in) { 60 }

      it '指定した秒数のPresigned URLを取得すること' do
        expect(subject).to include("https://#{bucket_name}.s3.#{Rails.configuration.x.lib_aws.region}.amazonaws.com/#{key}")
      end
    end
  end

  describe '#generate_s3_key' do
    subject { described_class.new.generate_s3_key(prefix: prefix, file_name: file_name) }
    let(:random_uuid) { SecureRandom.uuid }
    let(:prefix) { 'test-prefix' }
    let(:file_name) { 'test-filen-name.jpg' }

    before do
      allow(SecureRandom).to receive(:uuid).and_return(random_uuid)
    end

    it 'S3のキーを生成すること' do
      expect(subject).to eq("#{prefix}/#{random_uuid}/#{file_name}")
    end
  end
end
