module Api
  module V1
    module FishingSpots
      class SearchParameter
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :name, :string
        attribute :prefecture_id, :string
        attribute :fishes, array: true

        validate :prefecture_exists, if: -> { prefecture_id.present? }
        validate :fishes_exists, if: -> { fishes.present? }

        def initialize(params)
          permitted_params = params.permit(
            :name,
            :prefecture_id,
            fishes: [:id]
          )
          super(permitted_params.to_h.deep_symbolize_keys)
        end

        attr_reader :fishes, :prefecture

        private

        def prefecture_exists
          @prefecture = ::Prefecture.find_by(id: prefecture_id)
          return if @prefecture.present?

          errors.add(:prefecture_id, 'が見つかりません')
        end

        def fishes_exists
          @fishes = ::Fish.where(id: fishes.map { |fish| fish[:id] })

          return if @fishes.present?

          errors.add(:fishes, 'が見つかりません')
        end
      end
    end
  end
end
