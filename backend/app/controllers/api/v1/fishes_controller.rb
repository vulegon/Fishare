module Api
  module V1
    class FishesController < ApplicationController
      # 魚のマスターの一覧を取得する
      def index
        fishes = Fish.all
        serialized_fishes = ActiveModelSerializers::SerializableResource.new(fishes, each_serializer: ::Api::V1::FishSerializer).as_json

        json = { message: '都道府県を取得しました', fishes: serialized_fishes }
        render json: json, status: :ok
      end
    end
  end
end
