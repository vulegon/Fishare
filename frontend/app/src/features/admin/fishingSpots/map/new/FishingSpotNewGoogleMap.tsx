import { useState, useRef, useCallback } from 'react';
import { GoogleMap, MarkerF } from '@react-google-maps/api';

interface FishingSpotNewGoogleMapProps {
  lat: number;
  lng: number;
}

// 釣り場の新規作成画面で使用するGoogleMapコンポーネント
export const FishingSpotNewGoogleMap: React.FC<FishingSpotNewGoogleMapProps> = ({
  lat,
  lng
}) => {
  const [marker, setMarker] = useState<google.maps.LatLngLiteral>({ lat: lat, lng: lng });
  const center = useRef({ lat: lat, lng: lng });

  const onMapClick = useCallback((e: google.maps.MapMouseEvent) => {
    if (!e.latLng) return;
    setMarker({ lat: e.latLng.lat(), lng: e.latLng.lng() });
  }, []);

  return (
    <GoogleMap
      mapContainerStyle={{
        height: '400px',
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
      <MarkerF
        position={marker}
        icon={{
          // マーカーのアイコンを変更
          // https://www.single-life.tokyo/google-maps%EF%BC%88%E3%82%B0%E3%83%BC%E3%82%B0%E3%83%AB%E3%83%9E%E3%83%83%E3%83%97%EF%BC%89%E3%81%A7%E4%BD%BF%E3%81%88%E3%82%8B%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3/#i-5
          url: 'https://maps.google.com/mapfiles/kml/paddle/grn-circle.png', // カスタムアイコンURL
          scaledSize: new window.google.maps.Size(50, 50)
        }}
      />
    </GoogleMap>
  );
};
