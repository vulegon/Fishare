# == Schema Information
#
# Table name: contact_categories
#
#  id                        :uuid             not null, primary key
#  description(カテゴリ説明) :string
#  name(カテゴリ名)          :string           not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
FactoryBot.define do
  factory :support_contact_category, class: 'Supports::ContactCategory' do
    name { "その他" }
  end
end
