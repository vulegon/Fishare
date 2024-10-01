import axios, { AxiosInstance } from 'axios';
import { notifyError } from 'utils/notifyError';

const ADMIN_API_VERSION_PATH = '/api/v1/admin/';

class AdminApiClient {
  private client: AxiosInstance;

  constructor(baseURL: string) {
    this.client = axios.create({
      baseURL: `${baseURL}${ADMIN_API_VERSION_PATH}`,
      headers: {
        'Content-Type': 'application/json',
      },
    });
  }

  public async signIn(email: string, password: string): Promise<{ message: string }> {
    try {
      const response = await this.client.post('auth/sign_in', {
        email,
        password,
      });

      const token = response.headers['access-token'];
      const client = response.headers['client'];
      const uid = response.headers['uid'];

      if (token && client && uid) {
        localStorage.setItem('access-token', token);
        localStorage.setItem('client', response.headers['client']);
        localStorage.setItem('uid', response.headers['uid']);
      } else {
        throw new Error('トークンが見つかりません');
      }

      return { message: '管理者でログインしました' };
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }

  public async signOut(): Promise<{ message: string }> {
    try {
      const token = localStorage.getItem('access-token');
      const client = localStorage.getItem('client');
      const uid = localStorage.getItem('uid');
      if (!token || !client || !uid) {
        throw new Error('ログイン情報が不正です。キャッシュをクリアして再度ログインしてください');
      }

      await this.client.delete('auth/sign_out', {
        headers: {
          'access-token': token,
          'client': client,
          'uid': uid,
        },
      });

      localStorage.removeItem('access-token');
      localStorage.removeItem('client');
      localStorage.removeItem('uid');

      return { message: 'ログアウトに成功しました' };
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }
}

const baseURL = process.env.REACT_APP_API_BASE_URL || '';
const adminApiClient = new AdminApiClient(baseURL);
export default adminApiClient;
