import React from 'react';
import { Typography } from '@mui/material';
import { useParams } from 'react-router-dom';

export const PrefectureSpots: React.FC = () => {
  const { prefecture_id } = useParams();
  return (
    <>
      <Typography variant="h1">PrefectureSpots{prefecture_id}</Typography>
    </>
  );
};
