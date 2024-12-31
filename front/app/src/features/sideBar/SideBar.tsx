import DashboardIcon from "@mui/icons-material/Dashboard";
import ListIcon from "@mui/icons-material/List";
import MapIcon from "@mui/icons-material/Map";
import SupportAgentIcon from "@mui/icons-material/SupportAgent";
import { Box, Divider, List } from "@mui/material";
import MuiDrawer from "@mui/material/Drawer";
import { CSSObject, styled, Theme } from "@mui/material/styles";
import { CustomToolbar } from "components/common";
import { DRAWER_WIDTH } from "constants/index";
import { useUser } from "contexts/UserContext";
import React from "react";
import { SideBarListItem } from "./components";

// MUIのDrawerコンポーネントをカスタマイズする
// 参考
// https://mui.com/material-ui/react-drawer/
const openedMixin = (theme: Theme): CSSObject => ({
  width: DRAWER_WIDTH,
  transition: theme.transitions.create("width", {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.enteringScreen,
  }),
  overflowX: "hidden",
});

const closedMixin = (theme: Theme): CSSObject => ({
  transition: theme.transitions.create("width", {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  overflowX: "hidden",
  width: `calc(${theme.spacing(7)} + 1px)`,
  [theme.breakpoints.up("sm")]: {
    width: `calc(${theme.spacing(8)} + 1px)`,
  },
});

const Drawer = styled(MuiDrawer, {
  shouldForwardProp: (prop) => prop !== "open",
})(({ theme, open }) => ({
  width: DRAWER_WIDTH,
  flexShrink: 0,
  whiteSpace: "nowrap",
  boxSizing: "border-box",
  ...(open && {
    ...openedMixin(theme),
    "& .MuiDrawer-paper": openedMixin(theme),
  }),
  ...(!open && {
    ...closedMixin(theme),
    "& .MuiDrawer-paper": closedMixin(theme),
  }),
}));

const sideBarItems = [
  { label: "検索して探す", icon: <ListIcon />, path: "/fishing_spots/search" },
  { label: "地図から探す", icon: <MapIcon />, path: "/fishing_spots" },
  {
    label: "お問い合わせ",
    icon: <SupportAgentIcon />,
    path: "/supports/contacts/new",
  },
];

const adminSideBarItems = [
  {
    label: "ダッシュボード",
    icon: <DashboardIcon />,
    path: "/admin/dashboards",
  },
];

interface SideBarProps {
  open: boolean;
}

export const SideBar: React.FC<SideBarProps> = ({ open }) => {
  const { user } = useUser();

  return (
    <Drawer variant='permanent' open={open}>
      <CustomToolbar />
      <List>
        {sideBarItems.map((item) => (
          <SideBarListItem
            key={item.label}
            label={item.label}
            path={item.path}
            icon={item.icon}
            open={open}
          />
        ))}
        <Box sx={{ height: "10px" }} />
        {user && (
          <>
            <Divider />
            <Box sx={{ height: "20px" }} />
            {adminSideBarItems.map((item) => (
              <SideBarListItem
                key={item.label}
                label={item.label}
                path={item.path}
                icon={item.icon}
                open={open}
              />
            ))}
          </>
        )}
      </List>
    </Drawer>
  );
};
