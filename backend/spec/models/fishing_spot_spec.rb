# == Schema Information
#
# Table name: fishing_spots
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe FishingSpot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end