# == Schema Information
#
# Table name: support_contact_categories
#
#  id                        :uuid             not null, primary key
#  description(カテゴリ説明) :string
#  name(カテゴリ名)          :string           not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_support_contact_categories_on_name_unique  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe ::Supports::ContactCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
