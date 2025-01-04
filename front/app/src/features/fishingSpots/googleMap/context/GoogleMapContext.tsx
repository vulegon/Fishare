import { createContext, useState, useContext, ReactNode, useEffect, useCallback } from 'react';
import { getFishingSpotLocations } from 'api/v1/fishingSpotLocations';
import { FishingSpotLocation } from 'interfaces/api';

type Mode = 'detail' | 'edit' | 'create';

// Contextの型定義
interface GoogleMapContextType {
  mode: Mode | null;
  setMode: React.Dispatch<React.SetStateAction<Mode | null>>;
  isMode: (targetMode: Mode) => boolean
  existLocation: FishingSpotLocation[];
  setExistLocation: React.Dispatch<React.SetStateAction<FishingSpotLocation[]>>;
  newLocation: google.maps.LatLngLiteral | null;
  setNewLocation: React.Dispatch<React.SetStateAction<google.maps.LatLngLiteral | null>>;
  fetchFishingSpotLocations: () => Promise<FishingSpotLocation[]>;
  selectedExistLocation: FishingSpotLocation | null;
  setSelectedExistLocation: React.Dispatch<React.SetStateAction<FishingSpotLocation | null>>;
}

// Contextの初期値をnullに設定
const GoogleMapContext = createContext<GoogleMapContextType | null>(null);

// Providerの型定義
interface GoogleMapProviderProps {
  children: ReactNode;
}

// ユーザー情報を提供するためのProviderを作成
export const GoogleMapProvider = ({ children }: GoogleMapProviderProps) => {
  const [existLocation, setExistLocation] = useState<FishingSpotLocation[]>([]);
  const [newLocation, setNewLocation] = useState<google.maps.LatLngLiteral | null>(null);
  const [selectedExistLocation, setSelectedExistLocation] = useState<FishingSpotLocation | null>(null);
  const [mode, setMode] = useState<Mode | null>(null);

  // サーバーサイドから釣り場の位置情報を取得
  const fetchFishingSpotLocations = useCallback(async () => {
    const response = await getFishingSpotLocations();
    setExistLocation(response.fishingSpotLocations);
    return response.fishingSpotLocations;
  }, []);

  const isMode = (targetMode: Mode) => mode === targetMode;

  return (
    <GoogleMapContext.Provider
      value={{
        mode,
        setMode,
        isMode,
        existLocation,
        setExistLocation,
        newLocation,
        setNewLocation,
        fetchFishingSpotLocations,
        selectedExistLocation,
        setSelectedExistLocation,
      }}
    >
      {children}
    </GoogleMapContext.Provider>
  );
};

// Contextを利用するためのカスタムフック
export const useGoogleMap = (): GoogleMapContextType => {
  const context = useContext(GoogleMapContext);
  if (!context) {
    throw new Error('useGoogleMapはGoogleMapContextProvider内でのみ利用可能です');
  }
  return context;
};
