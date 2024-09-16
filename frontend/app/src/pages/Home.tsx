import React, { useEffect } from 'react';
import MainLayout from 'features/layouts/MainLayout';
import apiClient from 'api/v1/apiClient';

const Home: React.FC = () => {
  useEffect(() => {
    try {
      const response = apiClient.getPrefectures();
    } catch (error) {}
  }, []);

  return (
    <>
      <MainLayout>
        <div>aaa</div>
      </MainLayout>
    </>
  );
};

export default Home;
