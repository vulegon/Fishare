# == Schema Information
#
# Table name: fishing_spots
#
#  id                :uuid             not null, primary key
#  description(説明) :text             not null
#  name(釣り場名)    :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe FishingSpot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
