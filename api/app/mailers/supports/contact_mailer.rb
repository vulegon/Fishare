module Supports
  class ContactMailer < ApplicationMailer
    default from: ApplicationMailer::FROM_EMAIL

    # お問い合わせ完了メールを送信する
    # @param contact [Supports::Contact] お問い合わせ
    def send_complete_mail(contact)
      @contact = contact
      mail(
        to: @contact.email,  # 宛先
        subject: 'お問い合わせを受け付けました',  # メールの件名
        template_name: 'send_complete_mail'
      )
    end
  end
end
