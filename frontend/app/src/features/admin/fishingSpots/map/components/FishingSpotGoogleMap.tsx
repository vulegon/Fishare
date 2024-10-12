import { useState, useRef } from 'react';
import { HEADER_HEIGHT } from 'constants/index';
import Fab from '@mui/material/Fab';
import AddIcon from '@mui/icons-material/Add';
import { GoogleMap, Marker } from '@react-google-maps/api';
import { useNavigate } from 'react-router-dom';

interface FishingSpotGoogleMapProps {
  centerLat?: number;
  centerLng?: number;
  isOnSelectPage?: boolean;
  mapWidth?: string;
  mapHeight?: string;
}

export const FishingSpotGoogleMap: React.FC<FishingSpotGoogleMapProps> = ({
  centerLat = 35.681236,
  centerLng = 139.767125,
  isOnSelectPage = true,
  mapWidth = '100%',
  mapHeight = `calc(100vh - ${HEADER_HEIGHT}px)`,
}) => {
  const [marker, setMarker] = useState<google.maps.LatLngLiteral | null>(null);
  const center = useRef({ lat: centerLat, lng: centerLng }); // 東京駅
  const navigate = useNavigate();

  const onMapClick = (e: google.maps.MapMouseEvent) => {
    if (!e.latLng) return;
    setMarker({ lat: e.latLng.lat(), lng: e.latLng.lng() });
  };

  const onAddButtonClick = () => {
    if (!marker) return;
    navigate(`/admin/fishing_spots/map/new?lat=${marker.lat}&lng=${marker.lng}`);
  };

  return (
    <GoogleMap
      mapContainerStyle={{
        height: mapHeight,
        width: mapWidth,
      }}
      // optionsに入れない。クリックするとズームが変わる
      zoom={15}
      // optionsに入れないこと。また、クリックすると中心が変わらないようにuseRefで管理する
      center={center.current}
      options={{
        fullscreenControl: false,
        mapTypeId: 'hybrid'
      }}
      onClick={onMapClick}
    >
      {/* クリックしたマーカー */}
      {marker && (
        <Marker
          position={marker}
          icon={{
            // マーカーのアイコンを変更
            // https://www.single-life.tokyo/google-maps%EF%BC%88%E3%82%B0%E3%83%BC%E3%82%B0%E3%83%AB%E3%83%9E%E3%83%83%E3%83%97%EF%BC%89%E3%81%A7%E4%BD%BF%E3%81%88%E3%82%8B%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3/#i-5
            url: 'https://maps.google.com/mapfiles/kml/paddle/grn-circle.png', // カスタムアイコンURL
            scaledSize: new window.google.maps.Size(50, 50)
          }}
        />
      )}
      {
        isOnSelectPage && (
          <div style={{ position: 'absolute', bottom: '20px', right: '70px' }}>
            <Fab
              disabled={!marker}
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
        )
      }
    </GoogleMap>
  );
};
