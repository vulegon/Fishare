import React, { useState } from 'react';
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
import { FishingSpotNewLoadMap } from 'features/admin/fishingSpots/map/new/FishingSpotNewLoadMap';

export const FishingSpotNewPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const lat = searchParams.get('lat') ? parseFloat(searchParams.get('lat')!) : 35.681236;
  const lng = searchParams.get('lng') ? parseFloat(searchParams.get('lng')!) : 139.767125;

  return (
    <MainLayout>
      <Container fixed sx={{ mb: 6 }}>
        <Typography
          variant="h4"
          gutterBottom
          sx={{ fontWeight: 'bold', mt: 4 }}
        >
          釣り場登録
        </Typography>
        <Typography
          variant="subtitle2"
          gutterBottom
          sx={{ color: 'text.secondary', mb: 3 }}
        >
          地図のマーカーを動かして釣り場の位置を調整してください。
        </Typography>

        <Stack spacing={5}>
          {/* 地図コンポーネント */}
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
            <FishingSpotNewLoadMap lat={lat} lng={lng} />
          </Box>

          {/* フォーム入力フィールド */}
          <Stack spacing={3}>
            {/** 名称入力 **/}
            <Box>
              <Typography variant="body1" sx={{ fontWeight: 'bold', mb: 1 }}>
                名称
              </Typography>
              <TextField label="名称を入力" variant="outlined" fullWidth />
            </Box>

            {/** 住所入力 **/}
            <Box>
              <Typography variant="body1" sx={{ fontWeight: 'bold', mb: 1 }}>
                住所
              </Typography>
              <TextField label="住所を入力" variant="outlined" fullWidth />
            </Box>

            {/** 釣れる魚入力 **/}
            <Box>
              <Typography variant="body1" sx={{ fontWeight: 'bold', mb: 1 }}>
                釣れる魚
              </Typography>
              <TextField
                label="釣れる魚を入力"
                variant="outlined"
                fullWidth
                multiline
                rows={3}
              />
            </Box>

            {/** 備考入力 **/}
            <Box>
              <Typography variant="body1" sx={{ fontWeight: 'bold', mb: 1 }}>
                備考
              </Typography>
              <TextField
                label="備考を入力"
                variant="outlined"
                fullWidth
                multiline
                rows={3}
              />
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
