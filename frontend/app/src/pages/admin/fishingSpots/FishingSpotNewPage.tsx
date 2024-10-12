import React, { useRef, useState } from 'react';
import {
  Box,
  Typography
} from '@mui/material';
import { MainLayout } from 'features/layouts';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { FishingSpotLoadMap } from 'features/admin/fishingSpots/map/components';

export const FishingSpotNewPage: React.FC = () => {
  const navigate = useNavigate();
  const [marker, setMarker] = useState<google.maps.LatLngLiteral | null>(null);
  const [searchParams] = useSearchParams();
  const lat = searchParams.get('lat') ? parseFloat(searchParams.get('lat')!) : 35.681236;
  const lng = searchParams.get('lng') ? parseFloat(searchParams.get('lng')!) : 139.767125;

  return (
    <MainLayout>
      <Box
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
        <FishingSpotLoadMap
          centerLat={lat}
          centerLng={lng}
          isOnSelectPage={false}
          mapWidth='500px'
          mapHeight='300px'
        />
        <Box sx={{ height: 300 }}></Box>
      </Box>
    </MainLayout>
  );
};
