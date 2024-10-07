class EmailFormatValidator < ActiveModel::EachValidator
  EMAIL_REGEX = URI::MailTo::EMAIL_REGEXP

  class << self
    # メールアドレスの形式が正しいかどうかを返す
    # @param [String] email パスワード
    # @return [Boolean] パスワードの形式が正しいかどうか
    def valid_email_format?(email)
      return false if email.nil?

      email.match?(EMAIL_REGEX)
    end
  end

  def validate_each(record, attribute, value)
    unless self.class.valid_email_format?(value)
      record.errors.add attribute, (options[:message] ||I18n.t('activerecord.errors.models.user.attributes.email.format_invalid'))
    end
  end
end
