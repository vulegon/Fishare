import { Fish } from 'interfaces/api/Fish';
import { Prefecture } from 'interfaces/api/Prefecture';

export interface CreateFishingSpot {
  name: string;
  description: string;
  location: {
    prefecture: Prefecture;
    address: string;
    latitude: number;
    longitude: number;
  };
  images: File[];
  fish: Fish[];
}
