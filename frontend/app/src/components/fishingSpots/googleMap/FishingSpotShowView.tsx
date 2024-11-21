import React, { useEffect, useState, useCallback } from "react";
import { Drawer, Divider, Box, Stack, Typography } from "@mui/material";
import { streetViewClient } from "api/lib/libGoogle/streetViewClient";
import { FishingSpotLocation, FishingSpot } from "interfaces/api";
import { CenteredLoader } from "components/common";
import apiClient from "api/v1/apiClient";
import { styled } from "@mui/material/styles";

interface FishingSpotShowViewProps {
  selectedLocation: FishingSpotLocation | null;
  onClose: () => void;
}

const DRAWER_WIDTH = "500px";

const FishingSpotBox = styled(Box)({
  marginLeft: '16px',
});

export const FishingSpotShowView: React.FC<FishingSpotShowViewProps> = ({
  selectedLocation,
  onClose,
}) => {
  const [streetViewImageUrl, setStreetViewImageUrl] = useState<string | null>(null);
  const [isLoaded, setIsLoaded] = useState<boolean>(false);
  const [fishingSpot, setFishingSpot] = useState<FishingSpot | null>(null);

  const fetchStreetViewImage = useCallback(async () => {
    if (!selectedLocation) return;
    const response = await streetViewClient.fetchStreetViewImage(selectedLocation.latitude, selectedLocation.longitude);
    setStreetViewImageUrl(response);
  }, [selectedLocation]);

  const fetchFishingSpot = useCallback(async () => {
    if (!selectedLocation) return;
    const response = await apiClient.showFishingSpot(selectedLocation.id);
    setFishingSpot(response);
  }, [selectedLocation]);

  useEffect(() => {
    if (!selectedLocation) return;

    const fetchData = async () => {
      await Promise.all([fetchStreetViewImage(), fetchFishingSpot()]);
      setIsLoaded(true);
    };

    fetchData();
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
      <Stack spacing={2} useFlexGap>
        <Box
          sx={{
            height: '400px',
          }}
        >
          {
            (isLoaded) ?
              (
                <img src={streetViewImageUrl ?? undefined} alt="street view image" />
              ) : (
                <CenteredLoader/>
            )
          }
        </Box>
        <FishingSpotBox>
          <Typography variant="h5" sx={{fontWeight: 600}}>
            釣り場情報
          </Typography>
        </FishingSpotBox>
        <Divider />
        <FishingSpotBox>
          <Typography variant="subtitle1">
            {fishingSpot?.name}
          </Typography>
        </FishingSpotBox>
      </Stack>
    </Drawer>
  );
};
