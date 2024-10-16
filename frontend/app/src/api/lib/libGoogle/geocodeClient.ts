import axios from 'axios';
import { notifyError } from 'utils/toast/notifyError';
const GOOGLE_MAPS_API_KEY = process.env.REACT_APP_GOOGLE_MAP_API_KEY;

export const fetchAddress = async(
  lat: number,
  lng: number
): Promise<{ prefecture: string, address: string }> => {
    try {
      const response = await axios.get(
        `https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=${GOOGLE_MAPS_API_KEY}`,
        {
          params: {
          latlng: `${lat},${lng}`,
          key: GOOGLE_MAPS_API_KEY,
          }
        },
      )

      const formattedAddress = response.data.results[0].formatted_address;
      const fullAddress = formattedAddress
      .replace(/^日本[,、\s]*〒?\s*\d{3}-\d{4}\s*/, '') // 日本、〒マーク＋郵便番号を削除
      .replace(/^\s+|\s+$/g, ''); // 前後の余白を削除

      const prefecture = response.data.results[0].address_components.find((component: any) =>
        component.types.includes('administrative_area_level_1')
      );

      return {prefecture: prefecture, address: fullAddress};
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }

