module Api
  module V1
    module FishingSpots
      class UpdateParameter
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
        validate :images_must_be_valid, if: -> { images.present? }
        validate :latitude_and_longitude_must_be_valid, if: -> { location[:latitude].present? && location[:longitude].present? }
        validate :fishing_spot_exists

        def initialize(params)
          permitted_params = params.permit(
            :id,
            :name,
            :description,
            location: [ { prefecture: [:id, :name] }, :address, :latitude, :longitude],
            images: [:file_name, :s3_key, :content_type, :file_size, :s3_url, :display_order],
            fishes: [:id, :name]
          )
          super(permitted_params.to_h.deep_symbolize_keys)
          @fishing_spot = ::FishingSpot.find_by(id: params[:id])
          @prefecture = ::Prefecture.find_by(id: location[:prefecture][:id])
          @fishing_spot_fishes = ::Fish.where(id: fishes.map { |fish| fish[:id] })
          @image_forms = []
        end

        attr_reader :prefecture, :fishing_spot_fishes, :image_forms, :fishing_spot

        private

        def fishing_spot_exists
          return if fishing_spot.present?

          errors.add(:id, 'が見つかりません')
        end

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

        def images_must_be_valid
          @image_forms = images.map{ |image| ImageForm.new(image) }

          error_messages = []

          @image_forms.each do |image_form|
            error_messages << image_form.errors.full_messages.join('。') if image_form.invalid?
          end

          return if error_messages.blank?

          errors.add(:images, error_messages.join('。'))
        end

        def fishes_exists
          return if fishes.size == fishing_spot_fishes.size && fishing_spot_fishes.size > 0

          errors.add(:fishes, 'が指定されていないか、存在しない魚が含まれています')
        end

        def latitude_and_longitude_must_be_valid
          fishing_spot_location = ::FishingSpotLocation.where(latitude: location[:latitude], longitude: location[:longitude])
          return if fishing_spot_location.blank?

          errors.add(:location, 'の緯度経度は既に登録されています')
        end
      end
    end
  end
end
