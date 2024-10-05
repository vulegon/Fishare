// ユーザー情報の型定義
export interface User {
  id: string;
  name: string;
  email: string;
  isAdmin: boolean;
  authHeader: AuthHeader;
}

interface AuthHeader {
  accessToken: string;
  client: string;
  uid: string;
}
