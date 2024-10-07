# == Schema Information
#
# Table name: support_contacts
#
#  id                                      :uuid             not null, primary key
#  content                                 :text             not null
#  email                                   :string           not null
#  name                                    :string           not null
#  created_at                              :datetime         not null
#  updated_at                              :datetime         not null
#  support_contact_category_id(カテゴリID) :uuid             not null
#
require 'rails_helper'

RSpec.describe ::Supports::Contact, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
