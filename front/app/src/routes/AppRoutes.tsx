import { Contact, Home, NotFound, PrefectureSpots } from "pages";
import { AdminLoginPage, ContactReviewPage, DashBoardPage } from "pages/admin";
import {
  FishingSpotMapSelectPage,
  FishingSpotNewPage,
} from "pages/admin/fishingSpots";
import { GoogleMapPage, SearchPage, ShowPage } from "pages/fishingSpots";
import React from "react";
import { Route, BrowserRouter as Router, Routes } from "react-router-dom";
import { AdminRoutes } from "./admin/AdminRoutes";

const AppRoutes: React.FC = () => {
  return (
    <Router>
      <Routes>
        <Route path='/' element={<Home />} />
        <Route
          path='/prefectures/:id/fishing_spots'
          element={<PrefectureSpots />}
        />
        <Route path='/fishing_spots' element={<GoogleMapPage />} />
        <Route path='/fishing_spots/:id' element={<ShowPage />} />
        <Route path='/fishing_spots/search' element={<SearchPage />} />
        <Route path='/supports/contacts/new' element={<Contact />} />
        <Route path='/admin/sign_in' element={<AdminLoginPage />} />

        {/*管理者ページ*/}
        <Route
          path='/admin/*'
          element={
            <AdminRoutes>
              <Routes>
                <Route path='/dashboards' element={<DashBoardPage />} />
                <Route path='contacts' element={<ContactReviewPage />} />
                <Route
                  path='fishing_spots/map/new'
                  element={<FishingSpotMapSelectPage />}
                />
                {/* <Route
                  path='fishing_spots/map/new'
                  element={<FishingSpotNewPage />}
                /> */}
                <Route path='*' element={<NotFound />} />
              </Routes>
            </AdminRoutes>
          }
        />

        {/*どのルーティングにも当てはまらないとき*/}
        {/* NotFoundは一番最後に置くこと。 */}
        <Route path='*' element={<NotFound />} />
      </Routes>
    </Router>
  );
};

export default AppRoutes;
