import React from "react";
import { Drawer } from "@mui/material";

interface FishingSpotShowViewProps {
  fishingSpotId: string;
  onClose: () => void;
}

const DRAWER_WIDTH = "500px";

export const FishingSpotShowView: React.FC<FishingSpotShowViewProps> = ({
  fishingSpotId,
  onClose,
}) => {

  return (
    <Drawer
      sx={{
        width: DRAWER_WIDTH,
        flexShrink: 0,
        '& .MuiDrawer-paper': {
          width: DRAWER_WIDTH,
          boxSizing: 'border-box',
        },
      }}
      anchor={'right'}
      variant="temporary"
      open={!!fishingSpotId}
      onClose={onClose}
    >
      <div>
        <h2>釣り場詳細</h2>
        <p>釣り場ID: {fishingSpotId}</p>
      </div>
    </Drawer>
  );
};
