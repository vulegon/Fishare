import { apiClient } from 'api/v1/apiClient';
import { notifyError } from 'utils/toast/notifyError';
import { s3Client } from 'api/v1/s3Client';
import { CreateFishingSpot } from 'interfaces/api/admin/fishingSpots/CreateFishingSpot';
import { FishingSpot } from 'interfaces/api/FishingSpot';
import { generatePreSignedUrls } from 'api/v1/fishingSpotImages';

/*
  釣り場を作成します。
*/
export async function createFishingSpot(data: CreateFishingSpot): Promise<{ message: string }> {
  try {
    const preSignedUrlItems = await generatePreSignedUrls(data.images);

    const uploadFileS3Params = preSignedUrlItems.map((item) => {
      return {
        file: item.file,
        preSignedUrl: item.url,
      };
    });

    await s3Client.uploadAllFileS3(uploadFileS3Params);

    const createContactImages = preSignedUrlItems.map((item, index) => {
      return {
        s3_key: item.s3_key,
        file_name: item.file.name,
        content_type: item.file.type,
        file_size: item.file.size,
        display_order: index,
      };
    });

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
      images: createContactImages,
      fishes: data.fish
    };
    const response = await apiClient.post('fishing_spots', postData);

    return { message: response.data.message };
  } catch (error) {
    notifyError(error);
    throw error;
  }
}
