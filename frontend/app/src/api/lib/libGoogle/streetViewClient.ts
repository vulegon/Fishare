import axios from 'axios';
import { notifyError } from 'utils/toast/notifyError';
const GOOGLE_MAPS_API_KEY = process.env.REACT_APP_GOOGLE_MAP_API_KEY;

class StreetViewClient {
  // ストリートビューの画像を取得する
  public async fetchStreetViewImage(lat: number, lng: number, size?: string): Promise<string> {
    try {
      const imageSize = size || '600x400';
      const response = await axios.get(
        `https://maps.googleapis.com/maps/api/streetview?size=${imageSize}&location=${lat},${lng}&key=${GOOGLE_MAPS_API_KEY}`,
        {
          params: {
            size: imageSize,
            location: `${lat},${lng}`,
            key: GOOGLE_MAPS_API_KEY,
          },
          responseType: 'blob',
        },
      )

      const blobUrl = URL.createObjectURL(response.data);
      return blobUrl;
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }
}

export const streetViewClient = new StreetViewClient();
