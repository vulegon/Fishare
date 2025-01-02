module Api
  module V1
    module FishingSpots
      class SearchParameter
        include ::Api::V1::Concerns::Paginatable

        attribute :name, :string
        attribute :prefecture_id, :string
        attribute :fishes, array: true

        validate :prefecture_exists, if: -> { prefecture_id.present? }
        validate :fishes_exists, if: -> { fishes.present? }

        def initialize(params)
          permitted_params = params.permit(
            :name,
            :limit,
            :offset,
            :prefecture_id,
            fishes: [:id],
          )
          super(permitted_params.to_h.deep_symbolize_keys)
          @prefecture = ::Prefecture.find_by(id: prefecture_id)
        end

        attr_reader :fishing_spot_fishes, :prefecture

        private

        def prefecture_exists
          return if @prefecture.present?

          errors.add(:prefecture_id, 'が見つかりません')
        end

        def fishes_exists
          @fishing_spot_fishes = ::Fish.where(id: fishes.map { |fish| fish[:id] })

          return if @fishing_spot_fishes.size == fishes.size

          errors.add(:fishes, 'が見つかりません')
        end
      end
    end
  end
end
