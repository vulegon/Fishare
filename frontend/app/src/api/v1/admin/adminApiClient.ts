import axios, { AxiosInstance } from 'axios';
import { User } from 'interfaces/contexts/User';
import { notifyError } from 'utils/toast/notifyError';
import { CreateFishingSpot } from 'interfaces/api/admin/fishingSpots/CreateFishingSpot';
import { s3Client } from 'api/v1/s3Client';
const ADMIN_API_VERSION_PATH = '/api/v1/admin/';

class AdminApiClient {
  private client: AxiosInstance;

  constructor(baseURL: string) {
    this.client = axios.create({
      baseURL: `${baseURL}${ADMIN_API_VERSION_PATH}`,
      withCredentials: true,
      headers: {
        'Content-Type': 'application/json',
      },
    });
  }

  // ログイン
  public async signIn(email: string, password: string): Promise<User> {
    try {
      const response = await this.client.post('auth/sign_in', {
        email,
        password,
      });
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

  // ログアウト
  public async signOut(): Promise<{ message: string }> {
    try {
      await this.client.delete('auth/sign_out');

      return { message: 'ログアウトに成功しました' };
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }

  // 釣り場の作成
  public async createFishingSpot(data: CreateFishingSpot): Promise<{ message: string }> {
    try {
      const s3Images = await s3Client.uploadAllFileS3(data.images);
      const postData = {
        name: data.name,
        description: data.description,
        location: {
          prefecture: data.location.prefecture.id,
          address: data.location.address,
          latitude: data.location.latitude,
          longitude: data.location.longitude,
        },
        images: s3Images,
        fish: data.fish,
      }
      const response = await this.client.post('fishing_spots', postData);

      return { message: response.data.message };
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }
}

const baseURL = process.env.REACT_APP_API_BASE_URL || '';
const adminApiClient = new AdminApiClient(baseURL);
export default adminApiClient;
