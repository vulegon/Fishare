module Api
  module V1
    module Supports
      module ContactImages
        class ImageForm
          include ActiveModel::Model
          include ActiveModel::Attributes

          attribute :file_name, :string
          attribute :content_type, :string

          validates :file_name, :content_type, presence: true
        end
      end
    end
  end
end
