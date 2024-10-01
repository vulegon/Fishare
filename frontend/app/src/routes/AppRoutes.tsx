import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import {
  Home,
  NotFound,
  Contact,
  PrefectureSpots,
} from 'pages';
import {
  LoginPage,
  DashBoardPage
} from 'pages/admin';

const AppRoutes: React.FC = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/prefectures/:id/fishing_spots" element={<PrefectureSpots />} />
        <Route path="/google_maps" element={<Home />} />
        <Route path="/supports/contact" element={<Contact />} />
        <Route path="/admin/sign_in" element={<LoginPage />} />
        <Route path="/admin/dashboards" element={<DashBoardPage />} />

        {/*どのルーティングにも当てはまらないとき*/}
        {/* NotFoundは一番最後に置くこと。 */}
        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
};

export default AppRoutes;
