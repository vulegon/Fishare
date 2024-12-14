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
module Supports
  class ContactCategory < ApplicationRecord
    self.table_name = 'support_contact_categories'
    audited
    has_many :contacts, class_name: 'Supports::Contact', dependent: :destroy, foreign_key: :support_contact_category_id, inverse_of: :category

    validates :name, presence: true
  end
end

