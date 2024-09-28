# == Schema Information
#
# Table name: user_roles
#
#  id           :uuid             not null, primary key
#  role(権限)   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# ユーザーの権限を管理するモデル
class UserRole < ApplicationRecord
  audited

  enum role: {
    admin: 0 # 管理者
  }

  has_many :user_roleships, dependent: :destroy, inverse_of: :user_role
  has_many :users, through: :user_roleships
end
