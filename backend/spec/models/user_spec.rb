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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valid?' do
    subject { user.valid? }

    context '正常な値の場合' do
      let!(:user) { build(:user) }

      it { is_expected.to be true }
    end

    context 'nameに関して' do
      context 'nameがnilの場合' do
        let!(:user) { build(:user, name: nil) }

        it { is_expected.to be false }
      end

      context 'nameが空文字の場合' do
        let!(:user) { build(:user, name: '') }

        it { is_expected.to be false }
      end
    end

    context 'emailに関して' do
      context 'emailがnilの場合' do
        let!(:user) { build(:user, email: nil) }

        it { is_expected.to be false }
      end

      context 'emailが空文字の場合' do
        let!(:user) { build(:user, email: '') }

        it { is_expected.to be false }
      end

      context 'emailがメールアドレスの形式でない場合' do
        let!(:user) { build(:user, email: 'test') }

        it { is_expected.to be false }
      end

      context 'emailが重複している場合' do
        let!(:user) { build(:user, email: 'test_admin@fisharebackend.com') }
        let!(:user2) { create(:user, email: user.email) }

        it { is_expected.to be false }
      end
    end

    context 'passwordに関して' do
      context 'passwordがnilの場合' do
        let!(:user) { build(:user, password: nil) }

        it { is_expected.to be false }
      end

      context 'passwordが空文字の場合' do
        let!(:user) { build(:user, password: '') }

        it { is_expected.to be false }
      end

      context 'passwordが8文字未満の場合' do
        let!(:user) { build(:user, password: 'Pass123') }

        it { is_expected.to be false }
      end

      context 'passwordが128文字以上の場合' do
        let!(:user) { build(:user, password: 'Password12' * 12 + '123456789') }

        it { is_expected.to be false }
      end

      context 'passwordに大文字が含まれていない場合' do
        let!(:user) { build(:user, password: 'password123') }

        it { is_expected.to be false }
      end

      context 'passwordに小文字が含まれていない場合' do
        let!(:user) { build(:user, password: 'PASSWORD123') }

        it { is_expected.to be false }
      end

      context 'passwordに数字が含まれていない場合' do
        let!(:user) { build(:user, password: 'Password') }

        it { is_expected.to be false }
      end
    end

  end
  describe 'admin?' do
    subject { user.admin? }

    context '管理者ユーザー場合' do
      let!(:user) { create(:user, :admin) }

      it { is_expected.to be true }
    end

    context '管理者権限以外のユーザーの場合' do
      let!(:user) { create(:user) }

      it { is_expected.to be false }
    end
  end
end
