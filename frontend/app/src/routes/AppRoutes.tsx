import {
  Contact,
  Home,
  NotFound,
  PrefectureSpots,
} from 'pages';
import {
  AdminLoginPage,
  DashBoardPage,
  ContactReviewPage
} from 'pages/admin';
import React from 'react';
import { Route, BrowserRouter as Router, Routes } from 'react-router-dom';
import { AdminRoutes } from './admin/AdminRoutes';
import { FishingSpotMapPage } from 'pages/admin/fishingSpots';

const AppRoutes: React.FC = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/prefectures/:id/fishing_spots" element={<PrefectureSpots />} />
        <Route path="/google_maps" element={<Home />} />
        <Route path="/supports/contacts/new" element={<Contact />} />
        <Route path="/admin/sign_in" element={<AdminLoginPage />} />
        <Route
          path="/admin/dashboards"
          element={
            <AdminRoutes>
              <DashBoardPage />
            </AdminRoutes>
          }
        />

        <Route
          path="/admin/*"
          element={
            <AdminRoutes>
              <Routes>
                <Route path="contacts" element={<ContactReviewPage />} />
                <Route path="fishing_spots/map" element={<FishingSpotMapPage />} />
              </Routes>
            </AdminRoutes>
          }
        />

        {/*どのルーティングにも当てはまらないとき*/}
        {/* NotFoundは一番最後に置くこと。 */}
        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
};

export default AppRoutes;
