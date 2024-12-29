import { apiClient } from 'api/v1/apiClient';
import { GeneratePresignedUrlResponse } from 'interfaces/api/supports/GeneratePresignedUrlResponse';
import { GeneratePresignedUrlRequest } from 'interfaces/api/supports/GeneratePresignedUrlRequest';

interface PreSignedUrlItem {
  file: File;
  s3_key: string;
  url: string;
}

/*
  お問い合わせ画像をアップロードする用のPreSigned URLを生成する
  @param files: File[] アップロードするファイル
*/
export async function generatePreSignedUrls(files: File[]): Promise<PreSignedUrlItem[]> {
  try {
    const requestData: GeneratePresignedUrlRequest = {
      images: files.map((file) => {
        return {
          file_name: file.name,
          content_type: file.type,
        };
      }),
    };

    const response = await apiClient.post('supports/contact_images/generate_presigned_urls', requestData);
    const data: GeneratePresignedUrlResponse = response.data;

    const result: PreSignedUrlItem[] = data.images.map((item, index) => ({
      file: files[index],        // 元の File オブジェクト
      s3_key: item.s3_key,        // レスポンスの s3Key
      url: item.presigned_url,             // レスポンスの url
    }));

    return result;
  } catch (error) {
    throw error;
  }
}
