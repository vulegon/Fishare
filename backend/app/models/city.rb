# == Schema Information
#
# Table name: cities
#
#  id                        :uuid             not null, primary key
#  name(市区町村名)          :string           not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  prefecture_id(都道府県ID) :uuid             not null
#
# Indexes
#
#  index_cities_on_prefecture_id  (prefecture_id)
#
# Foreign Keys
#
#  fk_rails_...  (prefecture_id => prefectures.id)
#
class City < ApplicationRecord
  belongs_to :prefecture
end
