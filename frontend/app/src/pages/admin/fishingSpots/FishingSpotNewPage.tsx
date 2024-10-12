import React, { useRef, useState } from 'react';
import {
  Box,
  Typography
} from '@mui/material';
import { GoogleMap, Marker } from '@react-google-maps/api';
import { MainLayout } from 'features/layouts';
import { useNavigate, useSearchParams } from 'react-router-dom';

export const FishingSpotNewPage: React.FC = () => {
  const navigate = useNavigate();
  const [marker, setMarker] = useState<google.maps.LatLngLiteral | null>(null);
  const [searchParams] = useSearchParams();
  const center = useRef(
    {
      lat: searchParams.get('lat') ? parseFloat(searchParams.get('lat')!) : 35.681236,
      lng: searchParams.get('lng') ? parseFloat(searchParams.get('lng')!) : 139.767125
    }
  );

  return (
    <MainLayout>
      <div
        style={{
          marginTop: '40px',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        <Typography variant='h4' gutterBottom>
          釣り場の登録
        </Typography>
        <Typography variant='caption' gutterBottom style={{ color: 'grey' }}>
          地図のマーカーを動かすこともできます
        </Typography>
        <Box sx={{ height: 300 }}></Box>
      </div>
    </MainLayout>
  );
};
