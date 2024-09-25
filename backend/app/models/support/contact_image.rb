module Support
  class ContactImage < ApplicationRecord
    self.table_name = 'support_contact_images'
    audited
  end
end
