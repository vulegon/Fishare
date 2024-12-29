import { apiClient } from 'api/v1/apiClient';
import { notifyError } from 'utils/toast/notifyError';
import { s3Client } from 'api/v1/s3Client';
import { CreateFishingSpot } from 'interfaces/api/admin/fishingSpots/CreateFishingSpot';
import { FishingSpot } from 'interfaces/api/FishingSpot';
import { GeneratePresignedUrlResponse } from 'interfaces/api/supports/GeneratePresignedUrlResponse';
import { GeneratePresignedUrlRequest } from 'interfaces/api/supports/GeneratePresignedUrlRequest';
import { PreSignedUrlItem } from 'interfaces/api/s3/PresignedUrlItem';

/*
  釣り場を作成します。
*/
export async function createFishingSpot(data: CreateFishingSpot): Promise<{ message: string }> {
  try {
    const requestData: GeneratePresignedUrlRequest = {
      images: data.images.map((file) => {
        return {
          file_name: file.name,
          content_type: file.type,
        };
      }),
    };
    const preSignedUrlResponse = await apiClient.post('fishing_spots/generate_presigned_urls', requestData);
    const preSignedUrlData: GeneratePresignedUrlResponse = preSignedUrlResponse.data;

    const preSignedUrlItems: PreSignedUrlItem[] = preSignedUrlData.images.map((item, index) => ({
      file: data.images[index],        // 元の File オブジェクト
      s3_key: item.s3_key,        // レスポンスの s3Key
      url: item.presigned_url,             // レスポンスの url
    }));

    const uploadFileS3Params = preSignedUrlItems.map((item) => {
      return {
        file: item.file,
        preSignedUrl: item.url,
      };
    });

    const s3Images = await s3Client.uploadAllFileS3(uploadFileS3Params);

    const postData = {
      name: data.name,
      description: data.description,
      location: {
        prefecture: {
          id: data.location.prefecture.id,
          name: data.location.prefecture.name,
        },
        address: data.location.address,
        latitude: data.location.latitude,
        longitude: data.location.longitude,
      },
      images: s3Images,
      fishes: data.fish
    };
    const response = await apiClient.post('fishing_spots', postData);

    return { message: response.data.message };
  } catch (error) {
    notifyError(error);
    throw error;
  }
}

/*
  釣り場の詳細を取得します。
  @param id 釣り場ID
*/
export async function showFishingSpot(id: string): Promise<FishingSpot> {
    try {
      const response = await apiClient.get(`fishing_spot_locations/${id}/fishing_spot`);
      const data = response.data;
      return data.fishing_spot;
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }
