import { useRef } from 'react';
import { GoogleMap, MarkerF } from '@react-google-maps/api';

interface FishingSpotNewGoogleMapProps {
  marker: google.maps.LatLngLiteral;
  onMapClick?: (e: google.maps.MapMouseEvent) => void;
}

// 釣り場の新規作成画面で使用するGoogleMapコンポーネント
export const FishingSpotNewGoogleMap: React.FC<FishingSpotNewGoogleMapProps> = ({
  marker,
  onMapClick
}) => {
  const center = useRef(
    {
      lat: marker.lat,
      lng: marker.lng
    }
  );

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
        mapTypeId: 'hybrid',
        mapTypeControl: false, // 地図タイプの切り替え非表示
        streetViewControl: false, // ストリートビュー非表示
        rotateControl: false, // 回転ボタン非表示
        scaleControl: false, // スケールバー非表示
        zoomControl: true, // ズームコントロールを表示 (右下)
        gestureHandling: 'greedy', // ジェスチャーでズーム/移動可能に
        keyboardShortcuts: false, // キーボードショートカット無効化
        clickableIcons: false, // ポイントオブインタレストのアイコンを無効化
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
