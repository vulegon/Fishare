# == Schema Information
#
# Table name: fishing_spot_fishes
#
#  id                        :uuid             not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  fish_id(魚ID)             :uuid             not null
#  fishing_spot_id(釣り場ID) :uuid             not null
#
# Indexes
#
#  index_fishing_spot_fishes_on_fish_id          (fish_id)
#  index_fishing_spot_fishes_on_fishing_spot_id  (fishing_spot_id)
#
# Foreign Keys
#
#  fk_rails_...  (fish_id => fish.id)
#  fk_rails_...  (fishing_spot_id => fishing_spots.id)
#
require 'rails_helper'

RSpec.describe FishingSpotFish, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
