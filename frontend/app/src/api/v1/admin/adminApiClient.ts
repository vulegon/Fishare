import axios, { AxiosInstance } from 'axios';
import { notifyError } from 'utils/notifyError';
import { User } from 'interfaces/contexts/User';
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

  public async signIn(email: string, password: string): Promise<User> {
    try {
      const response = await this.client.post('auth/sign_in', {
        email,
        password,
      });
      const authHeader = {
        accessToken: response.headers['access-token'],
        client: response.headers['client'],
        uid: response.headers['uid'],
      }
      const user: User = {
        id: response.data.user.id,
        name: response.data.user.name,
        email: response.data.user.email,
        isAdmin: response.data.user.is_admin,
        authHeader: authHeader,
      }

      return user;
    } catch (error) {
      notifyError(error);
      throw error;
    }
  }

  public async signOut(user: User): Promise<{ message: string }> {
    try {
      const accessToken = user.authHeader.accessToken;
      const client = user.authHeader.client;
      const uid = user.authHeader.uid;

      if (!accessToken || !client || !uid) {
        throw new Error('ログイン情報が不正です。キャッシュをクリアして再度ログインしてください');
      }

      await this.client.delete('auth/sign_out', {
        headers: {
          'access-token': accessToken,
          'client': client,
          'uid': uid,
        },
      });

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
