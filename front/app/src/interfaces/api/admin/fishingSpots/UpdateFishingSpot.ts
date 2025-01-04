import { Fish } from 'interfaces/api/Fish';
import { Prefecture } from 'interfaces/api/Prefecture';
import { S3Image } from 'interfaces/api/s3';

export interface UpdateFishingSpot {
  name: string;
  description: string;
  location: {
    prefecture: Prefecture;
    address: string;
    latitude: number;
    longitude: number;
  };
  newImages: File[];
  fish: Fish[];
  existImages: S3Image[];
  imageOrders: {
    index: number
    isNew: boolean;
  }[]
}
