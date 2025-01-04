module Api
  module V1
    module FishingSpots
      class DestroyService
        class << self
          def destroy!(fishing_spot)
            ActiveRecord::Base.transaction do
              fishing_spot.destroy!
            end
          end
        end
      end
    end
  end
end
