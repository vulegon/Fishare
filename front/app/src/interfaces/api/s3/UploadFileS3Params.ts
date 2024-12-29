export interface UploadFileS3Params {
  // アップロードするファイル
  file: File;
  // アップロード用のPresigned URL
  preSignedUrl: string;
}
