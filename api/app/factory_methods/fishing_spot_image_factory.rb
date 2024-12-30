class FishingSpotImageFactory
  # 釣り場画像を生成する。永続化はしません。
  # @param [Api::V1::FishingSpots::ImageForm] param
  # @param [String] fishing_spot_id
  # @return [FishingSpotImage]
  def build(param, fishing_spot_id)
    image_id = SecureRandom.uuid
    ::FishingSpotImage.new(
      id: image_id,
      fishing_spot_id: fishing_spot_id,
      s3_key: param.s3_key,
      file_name: param.file_name,
      content_type: param.content_type,
      file_size: param.file_size,
      display_order: param.display_order.to_i
    )
  end

  # 釣り場画像を複数生成する。永続化はしません。
  # @param [Array<Api::V1::FishingSpots::ImageForm>] image_params
  # @param [String] fishing_spot_id
  # @return [Array<FishingSpotImage>]
  def build_all(image_params, fishing_spot_id)
    image_params.map do |image_param|
      build(image_param, fishing_spot_id)
    end
  end
end

