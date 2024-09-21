import React, { useEffect } from 'react';
import { MainLayout } from 'features/layouts';
import apiClient from 'api/v1/apiClient';
import { JapanMap } from 'features/japanMap/JapanMap';


const Home: React.FC = () => {

  return (
    <>
      <MainLayout>
        <JapanMap />
      </MainLayout>
    </>
  );
};

export default Home;
