import { FishingSpotLoadGoogleMap } from "components/fishingSpots/googleMap/";
import { MainLayout } from "features/layouts";
import React from "react";

export const FishingSpotMapSelectPage: React.FC = () => {
  return (
    <>
      <MainLayout mainContainerPadding={0}>
        <FishingSpotLoadGoogleMap
          isNew={true}
          isAdminPage={true}
        />
      </MainLayout>
    </>
  );
};
