import React, { useEffect, useState } from "react";
import { Drawer, Divider } from "@mui/material";
import { streetViewClient } from "api/lib/libGoogle/streetViewClient";
import { FishingSpotLocation } from "interfaces/api";
import { CenteredLoader } from "components/common";

interface FishingSpotShowViewProps {
  selectedLocation: FishingSpotLocation | null;
  onClose: () => void;
}

const DRAWER_WIDTH = "500px";

export const FishingSpotShowView: React.FC<FishingSpotShowViewProps> = ({
  selectedLocation,
  onClose,
}) => {
  const [streetViewImageUrl, setStreetViewImageUrl] = useState<string | null>(null);
  const [streetViewImageLoaded, setStreetViewImageLoaded] = useState<boolean>(false);
  const fetchStreetViewImage = async () => {
    if (!selectedLocation) return;
    const response = await streetViewClient.fetchStreetViewImage(selectedLocation.latitude, selectedLocation.longitude);
    setStreetViewImageUrl(response);
    setStreetViewImageLoaded(true);
  };

  useEffect(() => {
    fetchStreetViewImage();
  }, [selectedLocation]);
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
      open={!!selectedLocation}
      onClose={()=>{
        if (streetViewImageUrl) {
          URL.revokeObjectURL(streetViewImageUrl);
        }
        onClose();
      }}
    >
      { (streetViewImageUrl && streetViewImageLoaded) ?
        (
          <img src={streetViewImageUrl} alt="street view" />
        ) : (
          <CenteredLoader />
        )
      }
      <Divider />
    </Drawer>
  );
};
