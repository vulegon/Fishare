import React, { useEffect } from 'react';
import { MainLayout } from 'features/layouts';
import apiClient from 'api/v1/apiClient';

const Home: React.FC = () => {
  useEffect(() => {
    try {
      const response = apiClient.getPrefectures();
      // eslint-disable-next-line no-console
      console.log(response);
    } catch (error) {}
  }, []);

  return (
    <>
      <MainLayout>
        <div>Homeああああああああああああああああああああああああああああ</div>
      </MainLayout>
    </>
  );
};

export default Home;
