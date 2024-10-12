import { LoadScript } from '@react-google-maps/api';
import { CenteredLoader } from 'components/common';
import { FishingSpotGoogleMap } from './FishingSpotGoogleMap';
import React from 'react';

export const FishingSpotLoadMap: React.FC = () => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || '';

  return (
    <>
      {/* google api is already presented のエラー対策 */}
      { window.google === undefined ? (
        <LoadScript
          googleMapsApiKey={apiKey}
          loadingElement={<CenteredLoader/>}
        >
          <FishingSpotGoogleMap />
        </LoadScript>
        ) : (
          <FishingSpotGoogleMap />
      )}
    </>
  );
};
