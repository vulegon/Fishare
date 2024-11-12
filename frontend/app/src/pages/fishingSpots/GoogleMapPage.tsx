import { FishingSpotLoadGoogleMap } from "components/fishingSpots/googleMap/";
import { MainLayout } from "features/layouts";
import React from "react";

export const GoogleMapPage: React.FC = () => {
  return (
    <>
      <MainLayout mainContainerPadding={0}>
        <FishingSpotLoadGoogleMap />
      </MainLayout>
    </>
  );
};
