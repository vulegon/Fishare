import React from 'react';
import { MainLayout } from 'features/layouts';
import { Typography, Box } from '@mui/material';
import { LoadScript, GoogleMap, Marker } from '@react-google-maps/api';

export const FishingSpotMapPage: React.FC = () => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || '';

  return (
    <>
      <MainLayout>
        <LoadScript googleMapsApiKey={apiKey}>
          <GoogleMap
            mapContainerStyle={{
              height: '100vh',
              width: '100%',
            }}
          >
          </GoogleMap>
        </LoadScript>
      </MainLayout>
    </>
  );
};
