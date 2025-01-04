import { Fish } from 'interfaces/api/Fish';
import { Prefecture } from 'interfaces/api/Prefecture';
import { S3Image } from 'interfaces/api/s3/S3Image';

interface FishingSpot {
  id: string;
  name: string;
  description: string;
  location: {
    id: string;
    address: string;
    latitude: number;
    longitude: number;
    prefecture: Prefecture;
  };
  fishes: Fish[];
  images: S3Image[];
}
export interface SearchFishingSpotResponse {
  fishingSpots: FishingSpot[];
  limit: number;
  offset: number;
  count: number;
}
