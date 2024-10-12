import { LoadScript } from '@react-google-maps/api';
import { CenteredLoader } from 'components/common';
import { FishingSpotGoogleMap } from './FishingSpotGoogleMap';
import React from 'react';
import { HEADER_HEIGHT } from 'constants/index';

interface FishingSpotLoadMapProps {
  centerLat?: number;
  centerLng?: number;
  isOnSelectPage?: boolean;
  mapWidth?: string;
  mapHeight?: string;
}

export const FishingSpotLoadMap: React.FC<FishingSpotLoadMapProps> = ({
  centerLat = 35.681236,
  centerLng = 139.767125,
  isOnSelectPage = true,
  mapWidth = '100%',
  mapHeight = `calc(100vh - ${HEADER_HEIGHT}px)`,
}) => {
  const apiKey = process.env.REACT_APP_GOOGLE_MAP_API_KEY || '';

  return (
    <>
      {/* google api is already presented のエラー対策 */}
      { window.google === undefined ? (
        <LoadScript
          googleMapsApiKey={apiKey}
          loadingElement={<CenteredLoader/>}
        >
          <FishingSpotGoogleMap
            centerLat={centerLat}
            centerLng={centerLng}
            isOnSelectPage={isOnSelectPage}
            mapWidth={mapWidth}
            mapHeight={mapHeight}
          />
        </LoadScript>
        ) : (
          <FishingSpotGoogleMap
            centerLat={centerLat}
            centerLng={centerLng}
            isOnSelectPage={isOnSelectPage}
            mapWidth={mapWidth}
            mapHeight={mapHeight}
          />
      )}
    </>
  );
};
