import { apiClient } from 'api/v1/apiClient';
import { User } from 'interfaces/contexts/User';
import { notifyError } from 'utils/toast/notifyError';

/*
  ログインユーザーを取得します。
*/
export async function  getCurrentUser(): Promise<User | null> {
  try {
    const response = await apiClient.get('users/current_user');
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
