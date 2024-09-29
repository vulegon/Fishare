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
#  email(メールアドレス)    :string           not null
#  encrypted_password       :string           default(""), not null
#  failed_attempts          :integer          default(0), not null
#  locked_at                :datetime
#  name(名前)               :string           not null
#  provider                 :string           default("email"), not null
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string
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
  
end
