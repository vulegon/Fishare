import { FishingSpotLocation } from './FishingSpotLocation';
import { S3Image } from './s3';
import { Fish } from './Fish';

export interface FishingSpot {
  id: string;
  name: string;
  description: string;
  location: FishingSpotLocation;
  images: S3Image[];
  fishes: Fish[];
}
