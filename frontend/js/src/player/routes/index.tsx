import * as React from "react";
import { Outlet } from "react-router-dom";
import RouteLoader from "../../utils/Loader";

const getPlayerRoutes = () => {
  const routes = [
    {
      path: "/player/",
      element: <Outlet />,
      children: [
        {
          index: true,
          lazy: async () => {
            const PlayerPage = await import("../PlayerPage");
            return { Component: PlayerPage.PlayerPageWrapper };
          },
          loader: RouteLoader,
        },
        {
          path: "release/:releaseMBID",
          lazy: async () => {
            const PlayerPage = await import("../PlayerPage");
            return { Component: PlayerPage.PlayerPageWrapper };
          },
          loader: RouteLoader,
        },
      ],
    },
  ];
  return routes;
};

export default getPlayerRoutes;