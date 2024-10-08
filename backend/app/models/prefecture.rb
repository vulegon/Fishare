# == Schema Information
#
# Table name: prefectures
#
#  id               :uuid             not null, primary key
#  name(都道府県名) :string           not null
#  sort(並び順)     :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# 都道府県マスターテーブル
class Prefecture < ApplicationRecord
  has_many :fishing_spot_locations
end
