import React from 'react';
import { BeatLoader } from 'react-spinners';

interface CenteredLoaderProps {
  size?: number;
  color?: string;
}

export const CenteredLoader: React.FC<CenteredLoaderProps> = ({
  size = 20,
  color = '#1976D2',
}) => {
  return (
    <div style={{
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      height: '100vh'  // 全画面中央に配置
    }}>
      <BeatLoader size={size} color={color}/>
    </div>
  );
};
