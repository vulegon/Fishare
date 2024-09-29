require 'rails_helper'

RSpec.describe PasswordFormatValidator do
  describe '.valid_password?' do
    subject { described_class.valid_password?(password) }

    context 'パラメータが有効の場合' do
      context 'パスワードは8〜128文字で、大文字、小文字、数字を含んでいる場合' do
        let(:password) { 'Password123' }

        it { is_expected.to be true }
      end
    end

    context 'パラメータが無効の場合' do
      context 'パスワードが8文字未満の場合' do
        let(:password) { 'Pass123' }

        it { is_expected.to be false }
      end

      context 'パスワードが128文字以上の場合' do
        let(:password) { 'Password12' * 12 + '123456789' }

        it { is_expected.to be false }
      end

      context 'パスワードに大文字が含まれていない場合' do
        let(:password) { 'password123' }

        it { is_expected.to be false }
      end

      context 'パスワードに小文字が含まれていない場合' do
        let(:password) { 'PASSWORD123' }

        it { is_expected.to be false }
      end
    end
  end
end
