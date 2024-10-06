FactoryBot.define do
  factory :support_contact_image, class: 'Supports::ContactImage' do
    association :contact
    s3_key { "s3_key/contact_image.jpg" }
    s3_url { "s3_url/contact_image.jpg" }
    file_name { "contact_image.jpg" }
    content_type { "image/jpg" }
    file_size { 1024 }
  end
end
