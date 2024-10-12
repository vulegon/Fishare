import React from 'react';
import { MainLayout } from 'features/layouts';
import { FishingSpotLoadMap } from 'features/admin/fishingSpots/map/components';

export const FishingSpotMapSelectPage: React.FC = () => {
  return (
    <>
      <MainLayout mainContainerPadding={0}>
        <FishingSpotLoadMap/>
      </MainLayout>
    </>
  );
};
