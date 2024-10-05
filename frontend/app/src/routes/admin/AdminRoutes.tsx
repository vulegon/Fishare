import React, { useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { useUser } from 'contexts/UserContext';
import { notifyError } from 'utils/notifyError';
import { unknown } from 'zod';

interface AdminRouteProps {
  children: JSX.Element;
  adminOnly?: boolean;
}

export const AdminRoutes: React.FC<AdminRouteProps> = ({children, adminOnly = false}) => {
  const { user } = useUser();

  useEffect(() => {
    if (!user) {
      notifyError(unknown, '管理者としてログインしてください');
      return;
    }

    if (adminOnly && !user?.isAdmin) {
      notifyError(unknown, 'アクセスが拒否されました');
    }
  }, []);

   // ログインしていない場合、ログインページにリダイレクト
  if (!user) {
    return <Navigate to="/admin/sign_in" />;
  }

  // 管理者でない場合、アクセスを拒否してホームページへリダイレクト
  if (adminOnly && !user.isAdmin) {
    return <Navigate to="/" />;
  }

  // 管理者がログインしている場合のみ、コンテンツを表示
  return children;
};
