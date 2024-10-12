import React, { useState } from 'react';
import {
  Box,
  Typography,
  TextField,
  Stack
} from '@mui/material';
import { MainLayout } from 'features/layouts';
import Container from '@mui/material/Container';
import { useSearchParams } from 'react-router-dom';
import { FishingSpotNewLoadMap } from 'features/admin/fishingSpots/map/new/FishingSpotNewLoadMap';

export const FishingSpotNewPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const lat = searchParams.get('lat') ? parseFloat(searchParams.get('lat')!) : 35.681236;
  const lng = searchParams.get('lng') ? parseFloat(searchParams.get('lng')!) : 139.767125;

  return (
    <MainLayout>
      <Container fixed>
        <Typography variant='h4' gutterBottom>
          釣り場の登録
        </Typography>
        <Typography variant='caption' gutterBottom style={{ color: 'grey' }}>
          地図のマーカーを動かすこともできます
        </Typography>
        <Stack spacing={2}>
          <FishingSpotNewLoadMap
            lat={lat}
            lng={lng}
          />
          <Box>
            <Typography variant="body1" sx={{ fontWeight: 'bold' }}>
              釣り場の名前
            </Typography>
            <TextField
              label='釣り場の名前'
              variant='outlined'
              margin='normal'
              fullWidth
            />
          </Box>
          <Box>
        </Box>
        </Stack>
      </Container>
    </MainLayout>
  );
};
