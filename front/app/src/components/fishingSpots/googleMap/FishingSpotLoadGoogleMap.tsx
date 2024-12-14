import { LoadScript } from "@react-google-maps/api";
import { CenteredLoader } from "components/common";
import React from "react";
import { FishingSpotGoogleMap } from "./FishingSpotGoogleMap";

interface FishingSpotSelectLoadMapProps {
  isNew?: boolean;
}

// 釣り場を選択する画面で使用するGoogleMapを読み込むコンポーネント
export const FishingSpotLoadGoogleMap: React.FC<FishingSpotSelectLoadMapProps> = ({
  isNew = false,
}) => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || "";

  return (
    <>
      {/* google api is already presented のエラー対策 */}
      {window.google === undefined ? (
        <LoadScript
          googleMapsApiKey={apiKey}
          loadingElement={<CenteredLoader />}
        >
          <FishingSpotGoogleMap
            isNew={isNew}
          />
        </LoadScript>
      ) : (
        <FishingSpotGoogleMap
          isNew={isNew}
        />
      )}
    </>
  );
};
