import { useState, useRef, useCallback, useEffect } from 'react';
import { HEADER_HEIGHT } from 'constants/index';
import Fab from '@mui/material/Fab';
import AddIcon from '@mui/icons-material/Add';
import { GoogleMap, MarkerF } from '@react-google-maps/api';
import { useNavigate } from 'react-router-dom';
import apiClient from 'api/v1/apiClient'
import { FishingSpotLocation } from 'interfaces/api';
import { FishingSpotShowView } from './FishingSpotShowView';

interface FishingSpotGoogleMapProps {
  isNew?: boolean;
}

// 釣り場を選択する画面で使用するGoogleMapコンポーネント
export const FishingSpotGoogleMap: React.FC<FishingSpotGoogleMapProps> = ({
  isNew = false,
}) => {
  const [newLocation, setNewLocation] = useState<google.maps.LatLngLiteral | null>(null);
  const [existLocation, setExistLocation] = useState<FishingSpotLocation[]>([]);
  const center = useRef({ lat: 35.681236, lng: 139.767125 }); // 東京駅
  const navigate = useNavigate();
  const [selectedLocation, setSelectedLocation] = useState<FishingSpotLocation | null>(null);

  const fetchFishingSpotLocations = useCallback(async () => {
    const response = await apiClient.getFishingSpotLocations();
    setExistLocation(response.fishingSpotLocations);
  }, []);

  useEffect(() => {
    fetchFishingSpotLocations();
  }, []);

  const onMapClick = useCallback((e: google.maps.MapMouseEvent) => {
    if (!e.latLng) return;
    setNewLocation({ lat: e.latLng.lat(), lng: e.latLng.lng() });
  }, []);

  const onAddButtonClick = useCallback(() => {
    if (!newLocation) return;
    navigate(`/admin/fishing_spots/map/new?lat=${newLocation.lat}&lng=${newLocation.lng}`);
  }, [newLocation, navigate]);

  const onExistLocationClick = useCallback((fishingSpot: FishingSpotLocation) => {
    setSelectedLocation(fishingSpot);
  }, []);

  return (
    <GoogleMap
      mapContainerStyle={{
        height: `calc(100vh - ${HEADER_HEIGHT}px)`,
        width: '100%',
      }}
      // optionsに入れない。クリックするとズームが変わる
      zoom={15}
      // optionsに入れないこと。また、クリックすると中心が変わらないようにuseRefで管理する
      center={center.current}
      options={{
        fullscreenControl: false,
        mapTypeId: 'hybrid'
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
            // マーカーのアイコンを変更
            // https://www.single-life.tokyo/google-maps%EF%BC%88%E3%82%B0%E3%83%BC%E3%82%B0%E3%83%AB%E3%83%9E%E3%83%83%E3%83%97%EF%BC%89%E3%81%A7%E4%BD%BF%E3%81%88%E3%82%8B%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3/#i-5
            url: 'https://maps.google.com/mapfiles/kml/paddle/grn-circle.png', // カスタムアイコンURL
            scaledSize: new window.google.maps.Size(50, 50)
          }}
        />
      )}

      {/* APIから取得した釣り場 */}
      {existLocation.map((fishingSpot) => (
        <MarkerF
          key={fishingSpot.id}
          position={{ lat: fishingSpot.latitude, lng: fishingSpot.longitude }}
          onClick={()=>{
            onExistLocationClick(fishingSpot)
          }}
        />
      ))}

      {/* 釣り場追加ボタン */}
      { isNew && (
        <div style={{ position: 'absolute', bottom: '20px', right: '70px' }}>
          <Fab
            disabled={!newLocation}
            color='primary'
            aria-label='add'
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

      {/* 釣り場の情報 */}
      <FishingSpotShowView
        selectedLocation={selectedLocation}
        onClose={() => {
          setSelectedLocation(null)
        }}
      />
    </GoogleMap>
  );
};
