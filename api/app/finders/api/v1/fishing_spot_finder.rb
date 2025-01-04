module Api
  module V1
    class FishingSpotFinder
      def search(search_parameter)
        sort_order(search_query(search_parameter)).offset(search_parameter.offset).limit(search_parameter.limit)
      end

      def count(search_parameter)
        search_query(search_parameter).count
      end

      private

      def search_query(search_parameter)
        @search_query ||= build_query(search_parameter)
      end

      def build_query(search_parameter)
        fishing_spots = FishingSpot.all
        fishing_spots = join_to_fishing_spots(fishing_spots, search_parameter)
        fishing_spots = by_name(fishing_spots, search_parameter.name)
        fishing_spots = by_prefecture(fishing_spots, search_parameter.prefecture)
        fishing_spots = by_fishing_spot_fishes(fishing_spots, search_parameter.fishing_spot_fishes)

        fishing_spots.distinct
      end

      def join_to_fishing_spots(fishing_spots, search_parameter)
        fishing_spots = fishing_spots.joins(:location) if search_parameter.prefecture.present?
        fishing_spots = fishing_spots.joins(:fishing_spot_fishes) if search_parameter.fishing_spot_fishes.present?
        fishing_spots
      end

      def by_name(fishing_spots, name)
        return fishing_spots if name.blank?

        fishing_spots.name_like(name)
      end

      def by_prefecture(fishing_spots, prefecture)
        return fishing_spots if prefecture.blank?

        fishing_spots.where(fishing_spot_locations: { prefecture_id: prefecture.id })
      end

      def by_fishing_spot_fishes(fishing_spots, fishing_spot_fishes)
        return fishing_spots if fishing_spot_fishes.blank?

        fishing_spots.where(fishing_spot_fishes: { fish_id: fishing_spot_fishes.pluck(:id) })
      end

      def sort_order(query)
        query.order(updated_at: :desc)
      end
    end
  end
end
