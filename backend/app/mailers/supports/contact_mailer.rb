module Supports
  class ContactMailer < ApplicationMailer
    default from: 'fisharebackend@gmail.com'

    # お問い合わせ完了メールを送信する
    # @param contact [Supports::Contact] お問い合わせ
    def send_complete_mail(contact)
      @contact = contact
      mail(
        to: @contact.email,  # 宛先
        subject: 'お問い合わせ完了のお知らせ',  # メールの件名
        template_name: 'send_complete_mail'
      )
    end
  end
end
