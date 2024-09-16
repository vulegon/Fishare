import React, { useEffect } from 'react';
import MainLayout from 'features/layouts/MainLayout';
import { Toolbar } from '@mui/material';
import apiClient from 'api/v1/apiClient';

const Home: React.FC = () => {
  useEffect(() => {
    try {
      const response = apiClient.getPrefectures();
      console.log(response);
    } catch (error) {}
  }, []);

  return (
    <>
      <MainLayout>
      </MainLayout>
    </>
  );
};

export default Home;
