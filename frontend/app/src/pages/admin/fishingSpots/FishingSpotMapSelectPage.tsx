import { LoadScript } from '@react-google-maps/api';
import { CenteredLoader } from 'components/common';
import { Map } from 'features/admin/fishingSpots/map/Map';
import { MainLayout } from 'features/layouts';
import React from 'react';

export const FishingSpotMapSelectPage: React.FC = () => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || '';

  return (
    <>
      <MainLayout mainContainerPadding={0}>
        {/* google api is already presented のエラー対策 */}
      { window.google === undefined ? (
        <LoadScript
          googleMapsApiKey={apiKey}
          loadingElement={<CenteredLoader/>}
        >
          <Map />
        </LoadScript>
        ) : (
          <Map />
        )}
      </MainLayout>
    </>
  );
};
