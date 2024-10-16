import React, { useState, useEffect, useCallback } from 'react';
import {
  Box,
  Typography,
  TextField,
  Stack,
  Button
} from '@mui/material';
import { MainLayout } from 'features/layouts';
import Container from '@mui/material/Container';
import { useSearchParams } from 'react-router-dom';
import {
  FishingSpotNewLoadMap,
  Label
} from 'features/admin/fishingSpots/map/new/';
import { fetchAddress } from 'api/lib/libGoogle/geocodeClient';
import { Prefecture } from 'interfaces/api';
import apiClient from 'api/v1/apiClient';
import RoomIcon from '@mui/icons-material/Room';
import InfoIcon from '@mui/icons-material/Info';
import MapIcon from '@mui/icons-material/Map';
import { faFish } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import MyLocationIcon from '@mui/icons-material/MyLocation';

const spotLabels = [
  { label: '釣り場の名前', icon: <MyLocationIcon/>  },
  { label: '説明', icon: <InfoIcon/>  },
  { label: '住所', icon: <RoomIcon/>  },
  { label: '釣れる魚', icon: <FontAwesomeIcon icon={faFish}/>  },
  { label: '釣り場の場所', icon: <MapIcon/>  },
]

export const FishingSpotNewPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const lat = searchParams.get('lat') ? parseFloat(searchParams.get('lat')!) : 35.681236;
  const lng = searchParams.get('lng') ? parseFloat(searchParams.get('lng')!) : 139.767125;
  const [marker, setMarker] = useState<google.maps.LatLngLiteral>({ lat: lat, lng: lng });
  const [address, setAddress] = useState<string>('');
  const [prefecture, setPrefecture] = useState<Prefecture>();

  useEffect(() => {
    const fetch = async () => {
      const addressResponse = await fetchAddress(marker.lat, marker.lng);
      const prefectureData = await apiClient.getPrefectures();
      const findPrefecture = prefectureData.prefectures.find((pref: Prefecture)=> pref.name === addressResponse.prefecture);

      setAddress(addressResponse.address);
      setPrefecture(findPrefecture);
    };

    fetch();
  }, [marker, prefecture]);

  useEffect(() => {
  }, [prefecture]);

  const onMapClick = useCallback((e: google.maps.MapMouseEvent) => {
    if (!e.latLng) return;
    setMarker({ lat: e.latLng.lat(), lng: e.latLng.lng() });
  }, []);

  return (
    <MainLayout>
      <Container
        fixed
        sx={{
          mb: 6,
        }}
      >
      <Box
        sx={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          textAlign: 'center',
          mt: 4,
          mb: 3,
        }}
      >
        <Typography variant="h4" gutterBottom sx={{ fontWeight: 'bold' }}>
          釣り場登録
        </Typography>
      </Box>

        <Stack spacing={5}>
          <Stack spacing={3}>
            {/** 名称入力 **/}
            <Box>
              <Label label={'釣り場の名前'} icon={<MyLocationIcon/>}/>
              <TextField label="名称を入力" variant="outlined" fullWidth />
            </Box>

            {/** 住所入力 **/}
            <Box>
              <Label label={'住所'} icon={<RoomIcon/>}/>
              <TextField
                label="住所を入力"
                variant="outlined"
                fullWidth
                value={address}
              />
            </Box>

            {/** 釣れる魚入力 **/}
            <Box>
              <Label
                label={'釣れる魚'}
                icon={<FontAwesomeIcon icon={faFish} style={{ fontSize: '23px' }}/>}
              />
              <TextField
                label="釣れる魚を入力"
                variant="outlined"
                fullWidth
                multiline
                rows={3}
              />
            </Box>

            <Box>
              <Label label={'説明'} icon={<InfoIcon/>}/>
              <TextField
                label="備考を入力"
                variant="outlined"
                fullWidth
                multiline
                rows={3}
              />
            </Box>

            <Box>
              <Label label={'釣り場の場所'} icon={<MapIcon/>}/>
              <Box
                sx={{
                  borderRadius: 2,
                  overflow: 'hidden',
                  boxShadow: 3,
                  width: '100%',
                  height: '400px',
                  minWidth: '500px',
                }}
              >
                <FishingSpotNewLoadMap
                  marker={marker}
                  onMapClick={onMapClick}
                />
              </Box>
            </Box>
          </Stack>

          {/* 登録ボタン */}
          <Box sx={{ textAlign: 'center', mt: 4 }}>
            <Button variant="contained" color="primary" size="large">
              釣り場を登録する
            </Button>
          </Box>
        </Stack>
      </Container>
    </MainLayout>
  );
};
