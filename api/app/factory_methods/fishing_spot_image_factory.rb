class FishingSpotImageFactory
  def build(param, fishing_spot_id)
    image_id = SecureRandom.uuid
    ::FishingSpotImage.new(
      id: image_id,
      fishing_spot_id: fishing_spot_id,
      s3_key: param[:s3_key],
      s3_url: param[:s3_url],
      file_name: param[:file_name],
      content_type: param[:content_type],
      file_size: param[:file_size],
    )
  end

  def build_all(image_params, fishing_spot_id)
    image_params.map do |image_param|
      build(image_param, fishing_spot_id)
    end
  end
end

