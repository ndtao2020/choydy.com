import React from 'react';
import { IRoute } from '../interfaces/routing';

export const sessionRoutes: IRoute[] = [
  {
    path: 'page-404',
    component: React.lazy(() => import("../pages/sessions/404"))
  },
  {
    path: 'page-500',
    component: React.lazy(() => import("../pages/sessions/500"))
  },
  {
    path: 'sign-in',
    component: React.lazy(() => import("../pages/sessions/Sign-in"))
  },
  {
    path: 'sign-up',
    component: React.lazy(() => import("../pages/sessions/Sign-up"))
  }
];
