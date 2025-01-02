import { Fish } from 'interfaces/api/Fish';
import { Prefecture } from 'interfaces/api/Prefecture';

export interface SearchFishingSpotResponse {
  name: string;
  description: string;
  locations: {
    prefecture: Prefecture;
  }[];
  fishes: Fish[];
}
