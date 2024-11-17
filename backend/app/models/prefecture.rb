# == Schema Information
#
# Table name: prefectures
#
#  id                    :uuid             not null, primary key
#  display_order(並び順) :integer          not null
#  name(都道府県名)      :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_prefectures_on_name_unique  (name) UNIQUE
#
class Prefecture < ApplicationRecord
  has_many :fishing_spot_locations
end
