require 'rails_helper'

RSpec.describe ::Api::V1::Supports::Contacts::CreateService do
  describe '.create!' do
    subject { described_class.create!(create_params) }
    let(:create_params) { ::Api::V1::Supports::Contacts::CreateParameter.new(ActionController::Parameters.new(params)) }

    context "imagesが設定されている場合" do
      let(:params) {
        {
          name: 'name',
          email: 'hoge@example.com',
          content: 'content33333',
          images: [
            {
              s3_key: 's3_key',
              s3_url: 's3_url',
              file_name: 'file_name',
              content_type: 'content_type',
              file_size: 100
            },
            {
              s3_key: 's3_key2',
              s3_url: 's3_url2',
              file_name: 'file_name2',
              content_type: 'content_type2',
              file_size: 200
            },
          ]
        }
      }

      it 'contactとimagesが永続化されていること' do
        expect(subject).to be_a(Supports::Contact)
        expect(subject.reload).to have_attributes(
          name:  params[:name],
          email: params[:email],
          content: params[:content]
        )
        expect(subject).to be_persisted
        expect(subject.images).to match_array([
          have_attributes(
            s3_key: 's3_key',
            s3_url: 's3_url',
            file_name: 'file_name',
            content_type: 'content_type',
            file_size: 100
          ),
          have_attributes(
            s3_key: 's3_key2',
            s3_url: 's3_url2',
            file_name: 'file_name2',
            content_type: 'content_type2',
            file_size: 200
          )
        ])
        expect(subject.images).to all(be_persisted)
        expect(subject.images.count).to eq(2)
      end
    end

    context "imagesが設定されていない場合" do
      let(:params) {
        {
          name: 'name',
          email: 'hoge@example.com',
          content: 'content33333',
          images: []
        }
      }

      it 'contactが永続化されていること' do
        expect(subject).to be_a(Supports::Contact)
        expect(subject.reload).to have_attributes(
          name:  params[:name],
          email: params[:email],
          content: params[:content]
        )
        expect(subject).to be_persisted
        expect(subject.images).to be_empty
        expect(subject.images.count).to eq(0)
      end
    end
  end
end
