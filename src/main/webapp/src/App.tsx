import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import VerticalLayout from './layout/vertical/Vertical';
// import HorizontalLayout from './layout/horizontal/Horizontal';
import NotFound from './pages/sessions/404';
import { defaultRoutes, sessionRoutes } from './routing';
import './App.scss';
// import { useHideLoader } from './hooks/useHideLoader';
import React from 'react';

const App = () => {
  // useHideLoader();
  return (
    <BrowserRouter>
      <Routes>
        <Route path='/public'>
          {sessionRoutes.map((route, i) => (
            <Route
              key={i}
              path={`/public/${route.path}`}
              element={
                <React.Suspense fallback={<>...</>}>
                  <route.component />
                </React.Suspense>
              }
            />
          ))}
        </Route>
        <Route path='/vertical'>
          {defaultRoutes.map((route, i) => (
            <Route
              key={i}
              path={`/vertical/${route.path}`}
              element={
                <VerticalLayout>
                  <route.component />
                </VerticalLayout>
              }
            />
          ))}
        </Route>
        <Route path='/' element={<Navigate to="/vertical/default-dashboard" />} />
        <Route path='*' element={<NotFound />} />
      </Routes>
    </BrowserRouter>
  );
};

export default App;
