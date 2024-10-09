import React from 'react';
import { MainLayout } from 'features/layouts';
import { LoadScript, GoogleMap, Marker } from '@react-google-maps/api';
import { HEADER_HEIGHT } from 'constants/index';
import { Padding } from '@mui/icons-material';
import { dividerClasses } from '@mui/material';

export const FishingSpotMapPage: React.FC = () => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || '';

  return (
    <>
      <MainLayout mainContainerPadding={0}>
        <LoadScript googleMapsApiKey={apiKey} loadingElement={<div>Loading</div>}>
          <GoogleMap
            mapContainerStyle={{
              height: `calc(100vh - ${HEADER_HEIGHT}px)`,
              width: '100%',
            }}
          >
          </GoogleMap>
        </LoadScript>
      </MainLayout>
    </>
  );
};
