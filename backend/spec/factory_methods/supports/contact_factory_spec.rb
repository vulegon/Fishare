require 'rails_helper'

RSpec.describe Supports::ContactFactory do
  describe '#build' do
    subject { described_class.new.build(create_params) }
    let(:create_params) { Api::V1::Supports::Contacts::CreateParameter.new(ActionController::Parameters.new(params)) }
    let(:params) {
      {
        name: 'name',
        email: 'walkurepqrt@gmail.com',
        content: 'content',
        contact_category: 'other'
      }
    }

    it '永続化されていないcontactが返ってくること' do
      expect(subject).to be_a(Supports::Contact)
      expect(subject.id).to be_present
      expect(subject).to have_attributes(
        name:  params[:name],
        email: params[:email],
        content: params[:content]
      )
      expect(subject).not_to be_persisted
    end
  end
end
