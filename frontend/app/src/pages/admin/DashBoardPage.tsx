import React, { useEffect } from 'react';
import { MainLayout } from 'features/layouts';

export const DashBoardPage: React.FC = () => {

  useEffect(() => {
    const toke = localStorage.getItem('admin-access-token');
  }, []);
  return(
    <MainLayout>
      <div>ダッシュボード</div>
    </MainLayout>
  )
};
