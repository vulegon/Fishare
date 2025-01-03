module TestData
  module FishingSpots
    class FishingSpotLoader
      class << self
        def load
          fishing_spots = FishingSpot.all
          return if fishing_spots.present?

          create_fishing_spots = []
          create_fishing_spot_locations = []
          create_fishing_spot_fishes = []
          create_fishing_spot_images = []

          prefectures_hash = Prefecture.order(display_order: :asc).pluck(:name, :id).to_h
          fishes = Fish.all
          datasets = ::TestData::FishingSpots::Datasets.load

          datasets.each do |dataset|
            prefecture_id = prefectures_hash[dataset[:prefecture]]
            next unless prefecture_id
            new_fishing_spot = FishingSpot.new(
              id: SecureRandom.uuid,
              name: dataset[:name],
              description: dataset[:description],
            )

            create_fishing_spots << new_fishing_spot

            new_fishing_spot_location = FishingSpotLocation.new(
              id: SecureRandom.uuid,
              fishing_spot_id: new_fishing_spot.id,
              prefecture_id: prefecture_id,
              latitude: dataset[:latitude],
              longitude: dataset[:longitude],
              address: dataset[:address],
            )

            create_fishing_spot_locations << new_fishing_spot_location

            random_fish = fishes.sample
            new_fishing_spot_fish = FishingSpotFish.new(
              fishing_spot_id: new_fishing_spot.id,
              fish_id: random_fish.id,
            )

            create_fishing_spot_fishes << new_fishing_spot_fish

            2.times do |i|
              image_random_uuid = SecureRandom.uuid
              random_number = rand(1..10000)
              file_name = Faker::File.file_name(dir: '', ext: 'jpg')

              new_fishing_spot_images = FishingSpotImage.new(
                fishing_spot_id: new_fishing_spot.id,
                s3_key: "fishing_spots/#{image_random_uuid}#{file_name}",
                file_name: file_name,
                content_type: 'image/jpeg',
                file_size: random_number,
                display_order: i,
              )

              create_fishing_spot_images << new_fishing_spot_images
            end
          end

          ActiveRecord::Base.transaction do
            FishingSpot.import create_fishing_spots
            FishingSpotLocation.import create_fishing_spot_locations
            FishingSpotFish.import create_fishing_spot_fishes
            FishingSpotImage.import create_fishing_spot_images
          end
        end
      end
    end
  end
end
