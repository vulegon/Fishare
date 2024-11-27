module Supports
  class ContactImageFactory
    # お問い合わせ画像のデータを作成します。永続化は行いません。
    # @param param [Hash] お問い合わせ画像作成パラメータ
    # @param contact_id [String] お問い合わせID
    def build(param, contact_id)
      image_id = SecureRandom.uuid
      ::Supports::ContactImage.new(
        id: image_id,
        support_contact_id: contact_id,
        s3_key: param[:s3_key],
        file_name: param[:file_name],
        content_type: param[:content_type],
        file_size: param[:file_size],
      )
    end

    # 複数のお問い合わせ画像のデータを作成します。永続化は行いません。
    # @param image_params [Array<Hash>] お問い合わせ画像作成パラメータ
    # @param contact_id [String] お問い合わせID
    # @return [Array<Supports::ContactImage>]
    def build_all(image_params, contact_id)
      image_params.map do |image_param|
        build(image_param, contact_id)
      end
    end
  end
end
