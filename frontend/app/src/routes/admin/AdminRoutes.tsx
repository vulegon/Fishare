import React, { useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { useUser } from 'contexts/UserContext';
import { notifyError } from 'utils/notifyError';
import { unknown } from 'zod';
import { BeatLoader } from 'react-spinners';

interface AdminRouteProps {
  children: JSX.Element;
}

export const AdminRoutes: React.FC<AdminRouteProps> = ({children}) => {
  const { user, isLoading } = useUser();

  useEffect(() => {
    if(isLoading) {
      return;
    }

    if (!user) {
      notifyError(unknown, '管理者としてログインしてください');
      return;
    }

    if (!user?.isAdmin) {
      notifyError(unknown, 'アクセスが拒否されました');
    }
  }, [isLoading, user]);

  if(isLoading) {
    return (
      <div style={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '100vh'  // 全画面中央に配置
      }}>
        <BeatLoader size={20} color='#1976D2'/>
      </div>
    );
  }

   // ログインしていない場合、ログインページにリダイレクト
  if (!user) {
    return <Navigate to="/admin/sign_in" />;
  }

  // 管理者でない場合、アクセスを拒否してホームページへリダイレクト
  if (!user.isAdmin) {
    return <Navigate to="/" />;
  }

  // 管理者がログインしている場合のみ、コンテンツを表示
  return children;
};
