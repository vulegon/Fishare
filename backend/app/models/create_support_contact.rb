# == Schema Information
#
# Table name: create_support_contacts
#
#  id         :uuid             not null, primary key
#  content    :text             not null
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CreateSupportContact < ApplicationRecord
end
