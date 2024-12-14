require 'rails_helper'

RSpec.describe EmailFormatValidator do
  describe '.valid_email_format?' do
    subject { described_class.valid_email_format?(email) }

    context 'パラメータが有効の場合' do
      context 'メールアドレスの形式が正しいとき' do
        let(:email) { 'sample@example.com' }

        it { is_expected.to be true }
      end
    end

    context 'パラメータが無効の場合' do
      context '空欄の場合' do
        let(:email) { '' }

        it { is_expected.to be false }
      end

      context 'nilの場合' do
        let(:email) { nil }

        it { is_expected.to be false }
      end

      context '@より前に文字が存在しないとき' do
        let(:email) { '@example.com' }

        it { is_expected.to be false }
      end

      context 'メールアドレスに英数字以外が含まれるとき' do
        let(:email) { 'あ@example.com' }

        it { is_expected.to be false }
      end

      context 'メールアドレスの最後が英数字でないとき' do
        let(:email) { 'email@example.com-' }

        it { is_expected.to be false }
      end
    end
  end
end
