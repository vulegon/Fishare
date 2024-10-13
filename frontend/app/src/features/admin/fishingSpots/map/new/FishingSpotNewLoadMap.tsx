import React from 'react';
import { LoadScript } from '@react-google-maps/api';
import { CenteredLoader } from 'components/common';
import { FishingSpotNewGoogleMap } from './FishingSpotNewGoogleMap';

interface FishingSpotNewLoadMapProps {
  marker: google.maps.LatLngLiteral;
  onMapClick?: (e: google.maps.MapMouseEvent) => void;
}

// 釣り場の新規作成画面で使用するGoogleMapを読み込むコンポーネント
export const FishingSpotNewLoadMap: React.FC<FishingSpotNewLoadMapProps> = ({
  marker,
  onMapClick
}) => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || '';

  return (
    <>
      {/* google api is already presented のエラー対策 */}
      { window.google === undefined ? (
        <LoadScript
          googleMapsApiKey={apiKey}
          loadingElement={<CenteredLoader/>}
        >
          <FishingSpotNewGoogleMap
            marker={marker}
            onMapClick={onMapClick}
          />
        </LoadScript>
        ) : (
          <FishingSpotNewGoogleMap
            marker={marker}
            onMapClick={onMapClick}
          />
      )}
    </>
  );
};
