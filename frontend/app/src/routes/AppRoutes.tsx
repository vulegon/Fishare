import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Home, NotFound, Contact } from 'pages';

const AppRoutes: React.FC = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/contact" element={<Contact />} />

        {/*どのルーティングにも当てはまらないとき*/}
        {/* NotFoundは一番最後に置くこと。 */}
        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
};

export default AppRoutes;
