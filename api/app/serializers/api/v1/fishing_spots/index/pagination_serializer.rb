module Api
  module V1
    module FishingSpots
      module Index
        class PaginationSerializer < ActiveModel::Serializer
          attributes :fishing_spots, :count, :offset, :limit

          attr_reader :relation

          def initialize(relation, options = {})
            @relation = relation
            @count = options.delete(:count)

            super(relation, options)
          end

          def fishing_spots
            ActiveModel::Serializer::CollectionSerializer.new(
              relation.preload(locations: :prefecture, fishing_spot_fishes: :fish),
              serializer: ::Api::V1::FishingSpots::Index::FishingSpotSerializer,
            ).as_json
          end

          def count
            @count
          end

          def offset
            relation.offset_value
          end

          def limit
            relation.limit_value
          end
        end
      end
    end
  end
end
