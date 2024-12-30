import { apiClient } from 'api/v1/apiClient';
import { GeneratePresignedUrlResponse } from 'interfaces/api/supports/GeneratePresignedUrlResponse';
import { GeneratePresignedUrlRequest } from 'interfaces/api/supports/GeneratePresignedUrlRequest';
import { PreSignedUrlItem } from 'interfaces/api/s3/PresignedUrlItem';
/*
  釣り場画像をアップロードする用のPreSigned URLを生成する
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

    const response = await apiClient.post('fishing_spot_images/generate_presigned_urls', requestData);
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
