import axios, { AxiosInstance } from 'axios';

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
}
const baseURL = process.env.REACT_APP_API_BASE_URL || '';

const apiClient = new ApiClient(baseURL);
export default apiClient;