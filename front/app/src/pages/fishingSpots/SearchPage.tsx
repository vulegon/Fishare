import { MainLayout } from "features/layouts";
import React from "react";
import { SearchFishingSpots } from "features/fishingSpots/SearchFishingSpots";

export const SearchPage: React.FC = () => {
  return (
    <>
      <MainLayout>
        <SearchFishingSpots />
      </MainLayout>
    </>
  );
};
