module LibAws
  class S3Helper
    DEFAULT_PUT_URL_EXPIRATION = 900
    DEFAULT_GET_URL_EXPIRATION = 3600

    def initialize
      @s3_resource = Aws::S3::Resource.new(region: Rails.configuration.x.lib_aws.region)
    end

    # 画像をアップロードするPresigned URLを取得する
    def put_presigned_url(bucket_name:, key:, expires_in: DEFAULT_PUT_URL_EXPIRATION, content_type:)
      bucket = @s3_resource.bucket(bucket_name)

      bucket.object(key).presigned_url(:put, expires_in: expires_in, content_type: content_type)
    end

    # 画像を閲覧するPresigned URLを取得する
    def get_presigned_url(bucket_name:, key:, expires_in:)
      bucket = @s3_resource.bucket(bucket_name)
      expires_in ||= DEFAULT_GET_URL_EXPIRATION

      bucket.object(key).presigned_url(:get, expires_in: expires_in)
    end

    # s3_keyを生成する
    def generate_s3_key(prefix:, file_name:)
      "#{prefix}/#{SecureRandom.uuid}/#{file_name}"
    end
  end
end
