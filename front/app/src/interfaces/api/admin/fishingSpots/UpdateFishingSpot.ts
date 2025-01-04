import { Fish } from 'interfaces/api/Fish';
import { Prefecture } from 'interfaces/api/Prefecture';
import { S3Image } from 'interfaces/api/s3';

export type UpdateImage = File | S3Image;

export interface UpdateFishingSpot {
  name: string;
  description: string;
  location: {
    prefecture: Prefecture;
    address: string;
    latitude: number;
    longitude: number;
  };
  images: UpdateImage[];
  fish: Fish[];
}
