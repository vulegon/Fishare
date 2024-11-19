# == Schema Information
#
# Table name: fishing_spot_locations
#
#  id                        :uuid             not null, primary key
#  address(住所)             :string           not null
#  latitude(緯度)            :decimal(10, 8)   not null
#  longitude(経度)           :decimal(11, 8)   not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  fishing_spot_id(釣り場ID) :uuid             not null
#  prefecture_id(都道府県ID) :uuid             not null
#
# Indexes
#
#  index_fishing_spot_locations_on_fishing_spot_id                (fishing_spot_id)
#  index_fishing_spot_locations_on_latitude_and_longitude_unique  (latitude,longitude) UNIQUE
#  index_fishing_spot_locations_on_prefecture_id                  (prefecture_id)
#
# Foreign Keys
#
#  fk_rails_...  (fishing_spot_id => fishing_spots.id)
#  fk_rails_...  (prefecture_id => prefectures.id)
#
FactoryBot.define do
  factory :fishing_spot_location do
    association :fishing_spot
    association :prefecture
    address { "#{Faker::Address.state} #{Faker::Address.city} #{Faker::Address.street_address}" }
    latitude { BigDecimal(rand(20.0000000..46.0000000).round(7).to_s) }
    longitude { BigDecimal(rand(122.0000000..154.0000000).round(7).to_s) }
  end
end
