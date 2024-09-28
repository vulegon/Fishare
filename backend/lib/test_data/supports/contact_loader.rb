module TestData
  module Supports
    class ContactLoader
      class << self
        def load
          10.times do |i|
            contact = ::Supports::Contact.create!(name: Faker::Name.name, email: Faker::Internet.email, content: Faker::Lorem.sentence)
            2.times do |j|
              random_number = rand(1..1000000000)
              ::Supports::ContactImage.create!(
                support_contact_id: contact.id,
                s3_key: "supports/contact/#{SecureRandom.uuid}/image#{random_number}.jpg",
                s3_url: "https://s3-ap-northeast-1.amazonaws.com/supports/contact/#{SecureRandom.uuid}/image#{random_number}.jpg",
                file_name: "image#{random_number}.jpg",
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
