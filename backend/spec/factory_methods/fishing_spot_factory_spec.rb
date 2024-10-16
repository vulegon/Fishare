require 'rails_helper'

RSpec.describe FishingSpotFactory do
  describe '#build' do
    subject { described_class.new.build(create_params) }
      let!(:fish) { create(:fish) }
      let(:create_params) { Api::V1::FishingSpots::CreateParameter.new(ActionController::Parameters.new(params)) }
      let(:params) {
        {
          name: 'name',
          de1scription: 'description',
          fishes: [
            {
              id: fish.id,
              name: fish.name
            }
          ]
        }
      }

      it '永続化されていないcontactが返ってくること' do
        expect(subject).to be_a(FishingSpot)
        expect(subject.id).to be_present
        expect(subject).to have_attributes(
          name:  params[:name],
          description: params[:description]
        )
        expect(subject).not_to be_persisted
      end
  end
end
