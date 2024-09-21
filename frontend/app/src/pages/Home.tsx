import React from 'react';
import { MainLayout } from 'features/layouts';
import { JapanMap } from 'features/japanMap/JapanMap';
import { Typography, Box } from '@mui/material';

const Home: React.FC = () => {
  return (
    <>
      <MainLayout>
        <Box>
          <Typography variant='h6'>
            釣り場を地図から探しましょう。都道府県をクリックすると、その都道府県の釣り場が表示されます。
          </Typography>
          <JapanMap />
        </Box>
      </MainLayout>
    </>
  );
};

export default Home;
