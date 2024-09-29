# == Schema Information
#
# Table name: user_roles
#
#  id           :uuid             not null, primary key
#  role(権限)   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe UserRole, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
