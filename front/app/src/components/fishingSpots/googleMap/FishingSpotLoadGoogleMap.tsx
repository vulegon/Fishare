import { LoadScript, useJsApiLoader } from "@react-google-maps/api";
import { CenteredLoader } from "components/common";
import React from "react";
import { FishingSpotGoogleMap } from "./FishingSpotGoogleMap";
import { GoogleMapProvider } from "features/fishingSpots/googleMap/context/GoogleMapContext";

interface FishingSpotSelectLoadMapProps {
  isAdminPage?: boolean;
}

// 釣り場を選択する画面で使用するGoogleMapを読み込むコンポーネント
export const FishingSpotLoadGoogleMap: React.FC<FishingSpotSelectLoadMapProps> = ({
  isAdminPage = false
}) => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || "";

  /*
    本番の環境で以下のエラーが発生するため、useJsApiLoaderを使用している
    ReferenceError: google is not defined
    https://stackoverflow.com/questions/69676563/react-google-maps-api-referenceerror-google-is-not-defined
  */
  const { isLoaded } = useJsApiLoader({
    googleMapsApiKey: apiKey,
    region: "JP",
    language: "ja",
  });

  if (!isLoaded) {
    return <CenteredLoader />;
  }

  return (
    <>
      <GoogleMapProvider>
        {/* google api is already presented のエラー対策 */}
        {window.google === undefined ? (
          <LoadScript
            googleMapsApiKey={apiKey}
            loadingElement={<CenteredLoader />}
          >
            <FishingSpotGoogleMap
              isAdminPage={isAdminPage}
            />
          </LoadScript>
        ) : (
          <FishingSpotGoogleMap
            isAdminPage={isAdminPage}
          />
        )}
      </GoogleMapProvider>
    </>
  );
};
