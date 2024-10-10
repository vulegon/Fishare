import axios, { AxiosInstance } from 'axios';
import { S3Image } from 'interfaces/api/s3/S3Image';
import { notifyError } from 'utils/notifyError';
import { s3Client } from './s3Client';
import { User } from 'interfaces/contexts/User';

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
    prefectures: { id: string; name: string }[];
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
      const s3Images: S3Image[] = [];

      for (const image of data.images) {
        const uploadedImage = await s3Client.uploadContactFile(image);

        if (uploadedImage instanceof Error) {
          return { message: 'S3のアップロードに失敗しました。お問い合わせは送信されませんでした。' };
        }

        s3Images.push(uploadedImage);
      }

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
}

const baseURL = process.env.REACT_APP_API_BASE_URL || '';
const apiClient = new ApiClient(baseURL);
export default apiClient;
