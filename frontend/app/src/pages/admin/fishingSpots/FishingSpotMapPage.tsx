import React, { useState, useRef } from 'react';
import { MainLayout } from 'features/layouts';
import { LoadScript, GoogleMap, Marker } from '@react-google-maps/api';
import { HEADER_HEIGHT } from 'constants/index';
import { CenteredLoader } from 'components/common';
import Fab from '@mui/material/Fab';
import AddIcon from '@mui/icons-material/Add';

export const FishingSpotMapPage: React.FC = () => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || '';
  const [marker, setMarker] = useState<google.maps.LatLngLiteral | null>(null);

  const onMapClick = (e: google.maps.MapMouseEvent) => {
    if (!e.latLng) return;
    setMarker({ lat: e.latLng.lat(), lng: e.latLng.lng() });
  };

  return (
    <>
      <MainLayout mainContainerPadding={0}>
        <LoadScript googleMapsApiKey={apiKey} loadingElement={<CenteredLoader/>}>
          <GoogleMap
            mapContainerStyle={{
              height: `calc(100vh - ${HEADER_HEIGHT}px)`,
              width: '100%',
            }}
            // optionsにzoomとcenterを指定しないとGoogleMapの表示がされないため、注意
            options={{
              zoom: 15,
              center: { lat: 35.681236, lng: 139.767125 }, // 東京駅
              fullscreenControl: false,
              mapTypeId: 'hybrid'
            }}
            onClick={onMapClick}
          >
            {marker && <Marker position={marker} />}
            <div style={{ position: 'absolute', bottom: '20px', right: '70px' }}>
              <Fab
                disabled={!marker}
                color='primary'
                aria-label='add'
                sx={{
                  '&.Mui-disabled': {
                    backgroundColor: 'rgba(0, 123, 255, 0.5)', // ディセーブル時の背景色
                    color: 'rgba(255, 255, 255, 0.7)',         // ディセーブル時のアイコン色
                  },
                }}
              >
                <AddIcon />
              </Fab>
            </div>
          </GoogleMap>
        </LoadScript>
      </MainLayout>
    </>
  );
};
