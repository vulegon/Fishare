import { useUser } from 'contexts/UserContext';
import React, { useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { notifyError } from 'utils/toast/notifyError';
import { unknown } from 'zod';
import { CenteredLoader } from '../../components/common/CenteredLoader';

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
      <CenteredLoader />
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
