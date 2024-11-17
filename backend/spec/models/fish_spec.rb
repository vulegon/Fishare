# == Schema Information
#
# Table name: fish
#
#  id             :uuid             not null, primary key
#  name(魚の名前) :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_fish_on_name_unique  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Fish, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
