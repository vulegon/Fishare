require 'rails_helper'

RSpec.describe Supports::ContactImageFactory do
  describe '#build' do
    subject { described_class.new.build(image_params, contact_id) }
    let(:image_params) {
      {
        s3_key: 's3_key',
        file_name: 'file_name',
        content_type: 'content_type',
        file_size: 100
      }
    }
    let(:contact_id) { SecureRandom.uuid }

    it '永続化されていないcontac_imageが返ってくること' do
      expect(subject).to be_a(Supports::ContactImage)
      expect(subject.id).to be_present
      expect(subject).to have_attributes(
        support_contact_id: contact_id,
        s3_key: image_params[:s3_key],
        file_name: image_params[:file_name],
        content_type: image_params[:content_type],
        file_size: image_params[:file_size]
      )
      expect(subject).not_to be_persisted
    end
  end

  describe '#build_all' do
    subject { described_class.new.build_all(image_params, contact_id) }
    let(:image_params) {
      [
        {
          s3_key: 's3_key',
          file_name: 'file_name',
          content_type: 'content_type',
          file_size: 100
        },
        {
          s3_key: 's3_key2',
          file_name: 'file_name2',
          content_type: 'content_type2',
          file_size: 200
        },
      ]
    }
    let(:contact_id) { SecureRandom.uuid }

    it '永続化されていないcontac_imageの配列が返ってくること' do
      expect(subject).to all(be_a(Supports::ContactImage))
      expect(subject.size).to eq(2)
      expect(subject[0].id).to be_present
      expect(subject[0]).to have_attributes(
        support_contact_id: contact_id,
        s3_key: image_params[0][:s3_key],
        file_name: image_params[0][:file_name],
        content_type: image_params[0][:content_type],
        file_size: image_params[0][:file_size]
      )
      expect(subject[0]).not_to be_persisted
      expect(subject[1].id).to be_present
      expect(subject[1]).to have_attributes(
        support_contact_id: contact_id,
        s3_key: image_params[1][:s3_key],
        file_name: image_params[1][:file_name],
        content_type: image_params[1][:content_type],
        file_size: image_params[1][:file_size]
      )
      expect(subject[1]).not_to be_persisted
    end
  end
end
