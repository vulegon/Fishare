require "rails_helper"

RSpec.describe Supports::ContactMailer, type: :mailer do
  let_it_be(:contact_category) { create(:support_contact_category) }

  describe "#send_complete_mail" do
    let(:contact) { create(:support_contact, support_contact_category_id: contact_category.id) }
    let(:mail) { described_class.send_complete_mail(contact).deliver_now }

    it "お問い合わせメールが送信されること" do
      expect(mail.subject).to eq("お問い合わせを受け付けました")
      expect(mail.to).to eq([contact.email])
      expect(mail.from).to eq([ApplicationMailer::FROM_EMAIL])
    end
  end
end
