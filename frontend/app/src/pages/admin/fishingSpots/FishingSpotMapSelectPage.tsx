import React from 'react';
import { MainLayout } from 'features/layouts';
import { FishingSpotSelectLoadMap } from 'features/admin/fishingSpots/map/select/FishingSpotSelectLoadMap';

export const FishingSpotMapSelectPage: React.FC = () => {
  return (
    <>
      <MainLayout mainContainerPadding={0}>
        <FishingSpotSelectLoadMap/>
      </MainLayout>
    </>
  );
};
