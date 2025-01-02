export interface S3Image {
  id?: string;
  s3_key: string;
  file_name: string;
  content_type: string;
  file_size: number;
  display_order: number;
  presigned_url: string;
}
