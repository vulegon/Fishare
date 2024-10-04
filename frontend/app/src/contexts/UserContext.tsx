import React, { createContext, useState, useContext, ReactNode, useEffect } from 'react';
import { User } from 'interfaces/contexts/User';

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

  useEffect(() => {
    const user_id = localStorage.getItem('user_id');
    const user_name = localStorage.getItem('user_name');
    const user_email = localStorage.getItem('user_email');
    if (user_id && user_name && user_email) {
      setUser({ id: user_id, name: user_name, email: user_email });
    }
  }, []);

  const signIn = (userData: User) => {
    setUser(userData);
    localStorage.setItem('user_id', userData.id);
    localStorage.setItem('user_name', userData.name);
    localStorage.setItem('user_email', userData.email);
  };

  const signOut = () => {
    setUser(null);
    localStorage.removeItem('user_id');
    localStorage.removeItem('user_name');
    localStorage.removeItem('user_email');
  };

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
