module Api
  module V1
    class PrefecturesController < ::Api::V1::ApplicationController
      def index
        prefectures = Prefecture.all.order(display_order: :asc)
        serialized_prefectures = ActiveModelSerializers::SerializableResource.new(prefectures, each_serializer: ::Api::V1::PrefectureSerializer).as_json

        json = { message: '都道府県を取得しました', prefectures: serialized_prefectures }
        render json: json, status: :ok
      end
    end
  end
end
