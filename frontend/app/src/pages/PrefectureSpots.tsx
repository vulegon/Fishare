import React from 'react';
import { Typography } from '@mui/material';
import { useParams } from 'react-router-dom';
import { MainLayout } from 'features/layouts';

export const PrefectureSpots: React.FC = () => {
  const { prefecture_id } = useParams();
  return (
    <>
      <MainLayout >
        <Typography variant="h1">PrefectureSpots{prefecture_id}</Typography>
      </MainLayout >
    </>
  );
};
