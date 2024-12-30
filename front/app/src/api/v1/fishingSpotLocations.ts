import { apiClient } from 'api/v1/apiClient';
import { notifyError } from 'utils/toast/notifyError';
import { FishingSpotLocation } from 'interfaces/api/FishingSpotLocation';
import Decimal from 'decimal.js';
import { FishingSpot } from 'interfaces/api/FishingSpot';

/*
  釣り場の場所一覧を取得します。
*/
export async function getFishingSpotLocations(): Promise<{ fishingSpotLocations: FishingSpotLocation[] }> {
  try {
    const response = await apiClient.get('fishing_spot_locations');
    const data = response.data;
    const locations = data.fishing_spot_locations.map((fishingSpotLocation: FishingSpotLocation) => {
      return {
        id: fishingSpotLocation.id,
        fishing_spot_id: fishingSpotLocation.fishing_spot_id,
        prefecture_id: fishingSpotLocation.prefecture_id,
        address: fishingSpotLocation.address,
        latitude: new Decimal(fishingSpotLocation.latitude).toNumber(),
        longitude: new Decimal(fishingSpotLocation.longitude).toNumber(),
      }
    })
    return { fishingSpotLocations: locations };
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
