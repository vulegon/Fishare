import { useState, useRef, useCallback, useEffect } from 'react';
import { HEADER_HEIGHT } from 'constants/index';
import Fab from '@mui/material/Fab';
import AddIcon from '@mui/icons-material/Add';
import { GoogleMap, MarkerF } from '@react-google-maps/api';
import { useSearchParams } from 'react-router-dom';
import { FishingSpotLocation } from 'interfaces/api';
import { FishingSpotShowView } from './FishingSpotShowView';
import { getFishingSpotLocations } from 'api/v1/fishingSpotLocations';
import { FishingSpotCreateDrawer } from 'features/admin/fishingSpots/map/new/FishingSpotCreateDrawer';
import { CenteredLoader } from 'components/common';

interface FishingSpotGoogleMapProps {
  isNew?: boolean;
}

const DEFAULT_CENTER = { lat: 35.681236, lng: 139.767125 }; // 東京駅

// 釣り場を選択する画面で使用するGoogleMapコンポーネント
export const FishingSpotGoogleMap: React.FC<FishingSpotGoogleMapProps> = ({
  isNew = false,
}) => {
  const [newLocation, setNewLocation] = useState<google.maps.LatLngLiteral | null>(null);
  const [existLocation, setExistLocation] = useState<FishingSpotLocation[]>([]);
  const center = useRef(DEFAULT_CENTER);
  const [selectedLocation, setSelectedLocation] = useState<FishingSpotLocation | null>(null);
  const [searchParams, setSearchParams] = useSearchParams();
  const [isNewDrawerOpen, setIsNewDrawerOpen] = useState(false);
  const [isLoaded, setIsLoaded] = useState<boolean>(false);

  // サーバーサイドから釣り場の位置情報を取得
  const fetchFishingSpotLocations = useCallback(async () => {
    const response = await getFishingSpotLocations();
    setExistLocation(response.fishingSpotLocations);
    return response.fishingSpotLocations;
  }, []);

  useEffect(() => {
    const fetchData = async () => {
      // useStateの値は次のレンダリングのタイミングで反映されるので、existLocationは使わない。代わりにレスポンスのデータをそのまま使う。
      const fishingSpotLocations = await fetchFishingSpotLocations();
      const fishingSpotLocationId = searchParams.get('fishing_spot_location_id');

      if (fishingSpotLocationId){
        const selectedLocation = fishingSpotLocations.find((location) => location.id === fishingSpotLocationId);
        if (!selectedLocation) return; // URLにIDが指定されていないケースもあるので、その場合は何もしない
        setSelectedLocation(selectedLocation);
        center.current = { lat: selectedLocation.latitude, lng: selectedLocation.longitude };
      }
      setIsLoaded(true);
    };

    fetchData();
  }, [fetchFishingSpotLocations, isLoaded]);

  const onMapClick = useCallback((e: google.maps.MapMouseEvent) => {
    if (!e.latLng) return;
    setNewLocation({ lat: e.latLng.lat(), lng: e.latLng.lng() });
  }, []);

  const onAddButtonClick = useCallback(() => {
    if (!newLocation) return;
    setIsNewDrawerOpen(true);
  }, [newLocation]);

  const onExistLocationClick = useCallback((fishingSpotLocation: FishingSpotLocation) => {
    setSearchParams({
      fishing_spot_location_id: fishingSpotLocation.id,
    });
    setSelectedLocation(fishingSpotLocation);
    setIsNewDrawerOpen(false);
  }, []);

  return (
    <>
    {!isLoaded ? (
      <CenteredLoader />
    ) : (
      <>
        <GoogleMap
          mapContainerStyle={{
            height: `calc(100vh - ${HEADER_HEIGHT}px)`,
            width: '100%',
          }}
          zoom={15}
          center={center.current} // useStateは値が書き換わるたびに再描画されるたる。再描画されると画面がチラつくので、refを使って再描画を抑制する
          options={{
            fullscreenControl: false,
            mapTypeId: 'hybrid',
          }}
          onClick={(event: google.maps.MapMouseEvent) => {
            if (isNew) {
              onMapClick(event);
            }
          }}
        >
          {/* クリックしたマーカー */}
          {newLocation && (
            <MarkerF
              position={newLocation}
              icon={{
                url: 'https://maps.google.com/mapfiles/kml/paddle/grn-circle.png',
                scaledSize: new window.google.maps.Size(50, 50),
              }}
            />
          )}

          {/* 既存の釣り場 */}
          {existLocation.map((fishingSpot) => (
            <MarkerF
              key={fishingSpot.id}
              position={{ lat: fishingSpot.latitude, lng: fishingSpot.longitude }}
              onClick={() => {
                onExistLocationClick(fishingSpot);
              }}
            />
          ))}

          {/* 新規作成のボタン */}
          {isNew && (
            <div style={{ position: 'absolute', bottom: '20px', right: '70px' }}>
              <Fab
                disabled={!newLocation}
                color="primary"
                aria-label="add"
                sx={{
                  '&.Mui-disabled': {
                    backgroundColor: 'rgba(0, 123, 255, 0.5)',
                    color: 'rgba(255, 255, 255, 0.7)',
                  },
                }}
                onClick={onAddButtonClick}
              >
                <AddIcon />
              </Fab>
            </div>
          )}
          <FishingSpotShowView
            selectedLocation={selectedLocation}
            onClose={() => {
              setSelectedLocation(null);
            }}
          />
        </GoogleMap>

        {/* 釣り場を新規作成するドロワー */}
        {isNew && isNewDrawerOpen && newLocation &&(
          <FishingSpotCreateDrawer
            newLocation={newLocation}
            onClose={() => {
              setIsNewDrawerOpen(false);
            }}
            isDrawerOpen={isNewDrawerOpen}
          />
        )}
      </>
    )}
  </>
  );
};
