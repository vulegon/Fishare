import { FishingSpotLocation } from './FishingSpotLocation';
import { S3Image } from './s3';
import { Fish } from './Fish';

export interface FishingSpot {
  id: string;
  name: string;
  description: string;
  address: string;
  latitude: number;
  longitude: number;
  images: S3Image[];
  fishes: Fish[];
}
