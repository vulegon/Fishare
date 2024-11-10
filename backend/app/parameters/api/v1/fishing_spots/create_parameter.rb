module Api
  module V1
    module FishingSpots
      class CreateParameter
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :name, :string
        attribute :description, :string
        attribute :location, default: -> { {} }
        attribute :images, array: true
        attribute :fishes, array: true

        validates :name, :description, :location, presence: true
        validates :name, length: { maximum: 100 }
        validates :description, length: { minimum: 10 , maximum: 1000 }

        validate :prefecture_exists
        validate :location_exists
        validate :latitude_exists
        validate :longitude_exists
        validate :fishes_exists

        def initialize(params)
          permitted_params = params.permit(
            :name,
            :description,
            location: [ { prefecture: [:id, :name] }, :address, :latitude, :longitude],
            images: [:file_name, :s3_key, :content_type, :file_size, :s3_url],
            fishes: [:id, :name]
          )
          super(permitted_params.to_h.deep_symbolize_keys)
          @prefecture = ::Prefecture.find_by(id: location[:prefecture][:id])
          @fishing_spot_fishes = ::Fish.where(id: fishes.map { |fish| fish[:id] })
        end

        attr_reader :prefecture, :fishing_spot_fishes

        private

        def prefecture_exists
          return if prefecture.present?

          errors.add(:location, 'の都道府県が見つかりません')
        end

        def location_exists
          return if location[:address].present?

          errors.add(:location, 'の住所が未入力です')
        end

        def latitude_exists
          return if location[:latitude].present?

          errors.add(:location, 'の緯度が見つかりません')
        end

        def longitude_exists
          return if location[:longitude].present?

          errors.add(:location, 'の経度が見つかりません')
        end

        def fishes_exists
          return if fishes.size == fishing_spot_fishes.size && fishing_spot_fishes.size > 0

          errors.add(:fishes, 'が指定されていないか、存在しない魚が含まれています')
        end
      end
    end
  end
end
