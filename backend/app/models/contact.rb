module Support
  class Contact < ApplicationRecord
    self.table_name = 'support_contacts'
    audited
  end
end
