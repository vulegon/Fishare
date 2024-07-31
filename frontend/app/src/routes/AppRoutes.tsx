import React from 'react';
import { BrowserRouter as Routes, Route } from 'react-router-dom';
import { Home, NotFound } from '@pages';

const AppRoutes: React.FC = () => {
  return (
    <Routes>
        <Route path="/" element={ <Home/> } />

        {/*どのルーティングにも当てはまらないとき*/}
        {/* NotFoundは一番最後に置くこと。 */}
        <Route path="*" element={<NotFound />} />
    </Routes>
  );
};

export default AppRoutes;
