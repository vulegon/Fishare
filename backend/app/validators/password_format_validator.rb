class PasswordFormatValidator < ActiveModel::EachValidator
  PASSWORD_REGEX = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,128}\z/.freeze

  class << self
    # パスワードの形式が正しいかどうかを返す
    # 長さが8文字以上128文字以下であること
    # 少なくとも1つの数字を含むこと
    # 少なくとも1つの小文字のアルファベットを含むこと
    # 少なくとも1つの大文字のアルファベットを含むこと
    # @param [String] password パスワード
    # @return [Boolean] パスワードの形式が正しいかどうか
    def valid_password_format?(password)
      return false if password.nil?

      password.match?(PASSWORD_REGEX)
    end
  end

  def validate_each(record, attribute, value)
    unless self.class.valid_password_format?(value)
      record.errors.add attribute, (options[:message] ||I18n.t('activerecord.errors.models.user.attributes.password.invalid'))
    end
  end
end
