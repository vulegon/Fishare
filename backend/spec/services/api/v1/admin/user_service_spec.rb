require 'rails_helper'

RSpec.describe Api::V1::Admin::UserService do
  describe '.create_admin_user!' do
    subject { described_class.create_user_with_role!(email, password, role) }

    let(:email) { 'test_1@fishare.com' }
    let(:password) { 'Password123' }
    let!(:role) { create(:user_role, :admin) }

    it '管理者ユーザーが作成されること' do
      expect(subject).to be_a(User)
      expect(subject).to be_persisted
      expect(subject.email).to eq(email)
      expect(subject.valid_password?(password)).to be true
      expect(subject.admin?).to eq(true)
    end
  end
end
