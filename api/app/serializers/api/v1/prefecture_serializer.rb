module Api
  module V1
    class PrefectureSerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  end
end
