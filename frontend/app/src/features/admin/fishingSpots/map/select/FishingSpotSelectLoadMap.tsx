import React from 'react';
import { LoadScript } from '@react-google-maps/api';
import { CenteredLoader } from 'components/common';
import { FishingSpotSelectGoogleMap } from './FishingSpotSelectGoogleMap';

// 釣り場を選択する画面で使用するGoogleMapを読み込むコンポーネント
export const FishingSpotSelectLoadMap: React.FC = () => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || '';

  return (
    <>
      {/* google api is already presented のエラー対策 */}
      { window.google === undefined ? (
        <LoadScript
          googleMapsApiKey={apiKey}
          loadingElement={<CenteredLoader/>}
        >
          <FishingSpotSelectGoogleMap/>
        </LoadScript>
        ) : (
          <FishingSpotSelectGoogleMap/>
      )}
    </>
  );
};
