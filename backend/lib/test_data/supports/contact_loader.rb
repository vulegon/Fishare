module TestData
  module Supports
    class ContactLoader
      class << self
        def load
          ::Supports::ContactCategory.find_or_create_by!(name: "other", description: "その他")
          ::Supports::ContactCategory.find_or_create_by!(name: "manage_fishing_spot", description: "釣り場の作成・修正")
          ::Supports::ContactCategory.find_or_create_by!(name: "feature_request", description: "機能のリクエスト")
          ::Supports::ContactCategory.find_or_create_by!(name: "bug_report", description: "不具合の報告")

          10.times do |i|
            contact = ::Supports::Contact.create!(name: Faker::Name.name, email: Faker::Internet.email, content: Faker::Lorem.sentence, support_contact_category_id: ::Supports::ContactCategory.all.sample.id)
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
