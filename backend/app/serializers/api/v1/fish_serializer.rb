module Api
  module V1
    class FishSerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  end
end
