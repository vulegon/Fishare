interface GeneratePresignedUrl {
  presigned_url: string;
  s3_key: string;
}

export interface GeneratePresignedUrlResponse {
  images: GeneratePresignedUrl[];
}

