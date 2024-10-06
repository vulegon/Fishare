import React, { createContext, useState, useContext, ReactNode, useEffect } from 'react';
import { User } from 'interfaces/contexts/User';
import Cookies from 'js-cookie'

// Contextの型定義
interface UserContextType {
  user: User | null;
  signIn: (userData: User) => void;
  signOut: () => void;
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

  const signIn = (userData: User) => {
    setUser(userData);
  };

  const signOut = () => {
    setUser(null);
  };

  useEffect(() => {
    
  }, []);

  return (
    <UserContext.Provider value={{ user, signIn, signOut }}>
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
