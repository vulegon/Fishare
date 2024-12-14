import { createContext, useState, useContext, ReactNode, useEffect } from 'react';
import { User } from 'interfaces/contexts/User';
import apiClient from 'api/v1/apiClient';

// Contextの型定義
interface UserContextType {
  user: User | null;
  signIn: (userData: User) => void;
  signOut: () => void;
  isLoading: boolean
}

// Contextの初期値をnullに設定
const UserContext = createContext<UserContextType | undefined>(undefined);

// Providerの型定義
interface UserProviderProps {
  children: ReactNode;
}

// ユーザー情報を提供するためのProviderを作成
export const UserProvider = ({ children }: UserProviderProps) => {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);

  const signIn = (userData: User) => {
    setUser(userData);
    setIsLoading(false);
  };

  const signOut = () => {
    setUser(null);
    setIsLoading(false);
  };

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const currentUser = await apiClient.getCurrentUser();
        setUser(currentUser);
      } catch (error) {
        console.log(error);
      }
      setIsLoading(false);
    };

    fetchUser();
  }, []);

  return (
    <UserContext.Provider value={{ user, signIn, signOut, isLoading }}>
      {children}
    </UserContext.Provider>
  );
};

// Contextを利用するためのカスタムフック
export const useUser = (): UserContextType => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUserはUserProvider内でのみ利用可能です');
  }
  return context;
};
