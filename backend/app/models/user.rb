# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                       :uuid             not null, primary key
#  allow_password_change    :boolean          default(FALSE)
#  confirmation_sent_at     :datetime
#  confirmation_token       :string
#  confirmed_at             :datetime
#  current_sign_in_at       :datetime
#  current_sign_in_ip       :string
#  email(メールアドレス)    :string           not null
#  encrypted_password       :string           default(""), not null
#  failed_attempts          :integer          default(0), not null
#  last_sign_in_at          :datetime
#  last_sign_in_ip          :string
#  locked_at                :datetime
#  name(名前)               :string           not null
#  provider                 :string           default("email"), not null
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string
#  sign_in_count            :integer          default(0), not null
#  tokens                   :json
#  uid                      :string           default(""), not null
#  unconfirmed_email        :string
#  unlock_token             :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable
  include DeviseTokenAuth::Concerns::User
  audited except: :encrypted_password

  has_many :user_roleships, dependent: :destroy, inverse_of: :user
  has_many :user_roles, through: :user_roleships

  before_validation :downcase_email
  validates :name, presence: true
  validates :email, email_format: true, uniqueness: { case_sensitive: false }
  validates :password, password_format: true, if: :password_required?

  class << self
     # 認証トークンを基にユーザーを検索するメソッド
    def find_by_auth_token(access_token, client, uid)
      user = find_by(uid: uid)
      return user if user&.valid_token?(access_token, client)

      nil
    end
  end

  def admin?
    user_roles.exists?(role: :admin)
  end

  private

  # パスワードのバリデーションを必要な場合にのみ適用する
  def password_required?
    new_record? || password.present?
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
