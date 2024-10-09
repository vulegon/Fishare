import React from 'react';
import { MainLayout } from 'features/layouts';
import { LoadScript, GoogleMap, Marker } from '@react-google-maps/api';
import { HEADER_HEIGHT } from 'constants/index';
import { CenteredLoader } from 'components/common';

export const FishingSpotMapPage: React.FC = () => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || '';

  return (
    <>
      <MainLayout mainContainerPadding={0}>
        <LoadScript googleMapsApiKey={apiKey} loadingElement={<CenteredLoader/>}>
          <GoogleMap
            mapContainerStyle={{
              height: `calc(100vh - ${HEADER_HEIGHT}px)`,
              width: '100%',
            }}
            // optionsを指定しないとGoogleMapの表示がされないため、注意
            options={{
              zoom: 15,
              center: { lat: 35.681236, lng: 139.767125 }, // 東京駅
              fullscreenControl: false,
              mapTypeId: 'hybrid'
            }}
          >
          </GoogleMap>
        </LoadScript>
      </MainLayout>
    </>
  );
};
