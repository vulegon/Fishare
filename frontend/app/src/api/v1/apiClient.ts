import axios, { AxiosInstance } from 'axios';
import { s3Client } from './s3Client';

const API_VERSION_PATH = '/api/v1/';

class ApiClient {
  private client: AxiosInstance;

  constructor(baseURL: string) {
    this.client = axios.create({
      baseURL: `${baseURL}${API_VERSION_PATH}`,
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

  public async postContact(data: {
    name: string,
    email: string
    contactContent: string;
    images: File[];
  }): Promise<{ message: string }> {
   try {
      data.images.forEach(async (image) => {
        await s3Client.uploadContactFile(image);
      });

      const response = await this.client.post('supports/contact', {
        name: data.name,
        email: data.email,
        contact_content: data.contactContent,
      });

      const responseData = response.data;
      return { message: responseData.message };
    } catch (error) {
      console.error(error);

      return { message: 'エラーが発生しました' };
    }
  }
}
const baseURL = process.env.REACT_APP_API_BASE_URL || '';

const apiClient = new ApiClient(baseURL);
export default apiClient;
