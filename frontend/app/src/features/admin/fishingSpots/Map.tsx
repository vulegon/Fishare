import { useState, useRef } from 'react';
import { HEADER_HEIGHT } from 'constants/index';
import Fab from '@mui/material/Fab';
import AddIcon from '@mui/icons-material/Add';
import { GoogleMap, Marker } from '@react-google-maps/api';
import { useNavigate } from 'react-router-dom';

export const Map = () => {
  const [marker, setMarker] = useState<google.maps.LatLngLiteral | null>(null);
  const center = useRef({ lat: 35.681236, lng: 139.767125 }); // 東京駅
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
      onClick={onMapClick}
    >
      {marker && <Marker position={marker} />}
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
    </GoogleMap>
  );
};
