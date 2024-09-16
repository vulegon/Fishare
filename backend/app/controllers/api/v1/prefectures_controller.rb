module Api
  module V1
    class PrefecturesController < ApplicationController
      def index
        prefectures = Prefecture.all.sort_by{ |prefecture| ::Prefecture::NAMES.index(prefecture.name) }
        serialized_prefectures = ActiveModelSerializers::SerializableResource.new(prefectures, each_serializer: ::Api::V1::PrefectureSerializer).as_json

        a = 1

        json = { message: '都道府県を取得しました', prefectures: serialized_prefectures }
        render json: json, status: :ok
      end
    end
  end
end
