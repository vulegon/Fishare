module TestData
  module Supports
    class ContactLoader
      class << self
        def load
          10.times do |i|
            contact = ::Suports::Contact.create!(name: "test#{i}", email: "test#{i}@example.com")
            2.times do |j|
              ::Suports::ContactImage.create!(
                support_contact_id: contact.id,
                s3_key: "supports/contact/#{SecureRandom.uuid}/image#{j}.jpg",
                s3_url: "https://s3-ap-northeast-1.amazonaws.com/supports/contact/#{SecureRandom.uuid}/image#{j}.jpg",
                file_name: "image#{j}.jpg",
                content_type: "image/jpeg",
                file_size: 1024
              )
            end
          end
        end
      end
    end
  end
end
