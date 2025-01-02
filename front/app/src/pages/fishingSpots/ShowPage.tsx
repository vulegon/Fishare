import { MainLayout } from "features/layouts";
import React from "react";
import { ShowFishingSpot } from "features/fishingSpots/ShowFishingSpot";

export const ShowPage: React.FC = () => {
  return (
    <>
      <MainLayout>
        <ShowFishingSpot />
      </MainLayout>
    </>
  );
};
