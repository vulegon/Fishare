import { apiClient } from 'api/v1/apiClient';
import { Prefecture } from 'interfaces/api/Prefecture';

/*
  都道府県一覧を取得
*/
export async function getPrefectures(): Promise<{ prefectures: Prefecture[] }> {
  try {
    const response = await apiClient.get('prefectures');
    return { prefectures: response.data.prefectures };
  } catch (error) {
    console.error(error);
    return { prefectures: [] };
  }
}
