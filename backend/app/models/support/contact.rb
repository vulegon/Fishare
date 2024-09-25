module Support
  class Contact < ApplicationRecord
    self.table_name = 'support_contacts'
    audited

    validates :name, :email, :contact_content, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  end
end
