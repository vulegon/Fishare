import { apiClient } from 'api/v1/apiClient';
import { generatePreSignedUrls } from 'api/v1/fishingSpotImages';
import { s3Client } from 'api/v1/s3Client';
import { FishingSpotLocation } from 'interfaces/api';
import { CreateFishingSpot } from 'interfaces/api/admin/fishingSpots/CreateFishingSpot';
import { SearchFishingSpot } from 'interfaces/api/fishingSpots/SearchFishingSpot';
import { SearchFishingSpotResponse } from 'interfaces/api/fishingSpots/SearchFishingSpotResponse';
import { notifyError } from 'utils/toast/notifyError';
import { UpdateFishingSpot } from 'interfaces/api/admin/fishingSpots/UpdateFishingSpot';

/*
  釣り場を検索します。
  GET api/v1/fishing_spots
*/
export async function searchFishingSpot(data: SearchFishingSpot): Promise<SearchFishingSpotResponse> {
  try {
    const response = await apiClient.get('fishing_spots', { params: data });
    // API レスポンスを整形して型に適合させる
    const { fishing_spots, limit, offset, count } = response.data;

    return {
      fishingSpots: fishing_spots.map((spot: any) => ({
        id: spot.id,
        name: spot.name,
        description: spot.description,
        location: spot.location,
        fishes: spot.fishes,
        images: spot.images,
      })),
      limit,
      offset,
      count,
    };
  } catch (error) {
    notifyError(error);
    throw error;
  }
}


/*
  釣り場を作成します。
  POST api/v1/fishing_spots
*/
export async function createFishingSpot(data: CreateFishingSpot): Promise<{ fishing_spot_location: FishingSpotLocation }> {
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

    return { fishing_spot_location: response.data.fishing_spot };
  } catch (error) {
    notifyError(error);
    throw error;
  }
}

/*
  釣り場を更新します。
  PUT api/v1/fishing_spots
*/
export async function updateFishingSpot(data: UpdateFishingSpot): Promise<{ fishing_spot_location: FishingSpotLocation }> {
  try {
    // 画像のうち、File オブジェクトのものだけを抽出
    const uploadFiles = data.images
      .map((image, index) => (image instanceof File ? { file: image, index } : null))
      .filter((item): item is { file: File; index: number } => item !== null);
    const preSignedUrlItems = await generatePreSignedUrls(uploadFiles.map((item) => item.file));

    const uploadFileS3Params = preSignedUrlItems.map((item, idx) => ({
      file: uploadFiles[idx].file,
      preSignedUrl: item.url,
    }));

    await s3Client.uploadAllFileS3(uploadFileS3Params);

    const updateFishingSpotImages = data.images.map((item, index) => {
      if (item instanceof File) {
        // アップロード後のs3_keyを取得
        const fileIndex = uploadFiles.find((uploadItem) => uploadItem.index === index);
        const s3Key = fileIndex ? preSignedUrlItems[fileIndex.index].s3_key : "";
        return {
          s3_key: s3Key,
          file_name: item.name,
          content_type: item.type,
          file_size: item.size,
          display_order: index,
        };
      } else {
        // 既存画像はそのまま返す
        return item;
      }
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
      images: updateFishingSpotImages,
      fishes: data.fish
    };
    const response = await apiClient.put('fishing_spots', postData);

    return { fishing_spot_location: response.data.fishing_spot };
  } catch (error) {
    notifyError(error);
    throw error;
  }
}


/*
  釣り場を削除します
  DELETE api/v1/fishing_spots/:id
*/
export async function deleteFishingSpot(id: string): Promise<void> {
  try {
    const response = await apiClient.delete(`fishing_spots/${id}`);
  } catch (error) {
    notifyError(error);
    throw error;
  }
}
