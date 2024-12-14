require "rails_helper"

RSpec.describe Supports::ContactMailer, type: :mailer do
  describe "#send_complete_mail" do
    let(:contact) { create(:support_contact) }
    let(:mail) { described_class.send_complete_mail(contact).deliver_now }

    it "お問い合わせメールが送信されること" do
      expect(mail.subject).to eq("お問い合わせを受け付けました")
      expect(mail.to).to eq([contact.email])
      expect(mail.from).to eq([ApplicationMailer::FROM_EMAIL])
    end
  end
end
