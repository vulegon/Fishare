interface Image {
  file_name: string;
  content_type: string;
}

export interface GeneratePresignedUrlRequest {
  images: Image[];
}
