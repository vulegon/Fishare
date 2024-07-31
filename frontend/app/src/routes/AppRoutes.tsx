import React from 'react';
import { BrowserRouter as Routes, Route } from 'react-router-dom';
import { Home } from '@pages';

const AppRoutes: React.FC = () => {
  return (
    <Routes>
        <Route path="/" element={ <Home/> } />
    </Routes>
  );
};

export default AppRoutes;
