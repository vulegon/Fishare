module Api
  module V1
    module FishingSpots
      class ImageForm
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :file_name, :string
        attribute :s3_key, :string
        attribute :content_type, :string
        attribute :display_order, :integer
        attribute :file_size, :integer

        validates :file_name, :s3_key, :content_type, :file_size, :display_order, presence: true
      end
    end
  end
end
