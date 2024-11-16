import axios, { AxiosInstance } from 'axios';
import {
  Fish,
  Prefecture,
  FishingSpotLocation,
} from 'interfaces/api';
import { User } from 'interfaces/contexts/User';
import { notifyError } from 'utils/toast/notifyError';
import { s3Client } from './s3Client';
import { CreateFishingSpot } from 'interfaces/api/admin/fishingSpots/CreateFishingSpot';
import Decimal from 'decimal.js';

const API_VERSION_PATH = '/api/v1/';

class ApiClient {
  private client: AxiosInstance;

  constructor(baseURL: string) {
    this.client = axios.create({
      baseURL: `${baseURL}${API_VERSION_PATH}`,
      withCredentials: true,
      headers: {
        'Content-Type': 'application/json',
      },
    });
  }

  public async getPrefectures(): Promise<{
    message: string;
    prefectures: Prefecture[];
  }> {
    try {
      const response = await this.client.get('prefectures');
      const data = response.data;
      return { message: data.message, prefectures: data.prefectures };
    } catch (error) {
      console.error(error);
      return { message: 'error', prefectures: [] };
    }
  }

  public async createContact(data: {
    name: string,
    email: string
    contactContent: string;
    images: File[];
    contactCategory: string;
  }): Promise<{ message: string }> {
    try {
      const s3Images = await s3Client.uploadAllFileS3(data.images, 'supports/contact');

      const response = await this.client.post('supports/contact', {
        name: data.name,
        email: data.email,
        content: data.contactContent,
        images: s3Images,
        contact_category: data.contactCategory,
      });

      const responseData = response.data;
      return { message: responseData.message };
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }

  public async getCurrentUser(): Promise<User | null> {
    try {
      const response = await this.client.get('users/current_user');
      if (!response.data.user) {
        return null;
      }

      const user: User = {
        id: response.data.user.id,
        name: response.data.user.name,
        email: response.data.user.email,
        isAdmin: response.data.user.is_admin,
      }

      return user;
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }

  public async getFish(): Promise<{ fishes: Fish[] }>{
    try {
      const response = await this.client.get('fishes');
      const data = response.data;
      return { fishes: data.fishes };
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }

  // 釣り場の作成
  public async createFishingSpot(data: CreateFishingSpot): Promise<{ message: string }> {
    try {
      const s3Images = await s3Client.uploadAllFileS3(data.images, 'fishing_spots');
    console.log(data);

      const postData = {
        name: data.name,
        description: data.description,
        location: {
          prefecture: {
            id: data.location.prefecture.id,
            name: data.location.prefecture.name,
          },
          address: data.location.address,
          latitude: data.location.latitude,
          longitude: data.location.longitude,
        },
        images: s3Images,
        fishes: data.fish
      };
      const response = await this.client.post('fishing_spots', postData);

      return { message: response.data.message };
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }

  // 釣り場の場所を取得
  public async getFishingSpotLocations(): Promise<{ fishingSpotLocations: FishingSpotLocation[] }> {
    try {
      const response = await this.client.get('fishing_spot_locations');
      const data = response.data;
      const locations = data.fishing_spot_locations.map((fishingSpotLocation: FishingSpotLocation) => {
        return {
          id: fishingSpotLocation.id,
          fishing_spot_id: fishingSpotLocation.fishing_spot_id,
          prefecture_id: fishingSpotLocation.prefecture_id,
          address: fishingSpotLocation.address,
          latitude: new Decimal(fishingSpotLocation.latitude).toNumber(),
          longitude: new Decimal(fishingSpotLocation.longitude).toNumber(),
        }
      })
      return { fishingSpotLocations: locations };
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }
}

const baseURL = process.env.REACT_APP_API_BASE_URL || '';
const apiClient = new ApiClient(baseURL);
export default apiClient;
