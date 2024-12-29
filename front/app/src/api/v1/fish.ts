import { apiClient } from 'api/v1/apiClient';
import {
  Fish
} from 'interfaces/api';
import { notifyError } from 'utils/toast/notifyError';

/*
  魚のマスターデータを取得
*/
export async function getFish(): Promise<{ fishes: Fish[] }>{
  try {
    const response = await apiClient.get('fishes');
    const data = response.data;
    return { fishes: data.fishes };
  } catch (error) {
    notifyError(error);
    throw error;
  }
}
