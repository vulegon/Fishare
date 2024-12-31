import LocationOnIcon from "@mui/icons-material/LocationOn";
import {
  Box,
  Chip,
  Divider,
  Drawer,
  Grid,
  Stack,
  Typography,
  Card
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { streetViewClient } from "api/lib/libGoogle/streetViewClient";
import { showFishingSpot } from "api/v1/fishingSpotLocations";
import { CenteredLoader } from "components/common";
import { FishingSpot, FishingSpotLocation } from "interfaces/api";
import React, { useCallback, useEffect, useState } from "react";
import 'react-photo-view/dist/react-photo-view.css';
import { PhotoProvider, PhotoView } from 'react-photo-view';
import ZoomInIcon from '@mui/icons-material/ZoomIn';
import ZoomOutIcon from '@mui/icons-material/ZoomOut';
import RotateRightIcon from '@mui/icons-material/RotateRight';
import RotateLeftIcon from '@mui/icons-material/RotateLeft';

interface FishingSpotShowViewProps {
  selectedLocation: FishingSpotLocation | null;
  onClose: () => void;
}

const DRAWER_WIDTH = "500px";

const FishingSpotBox = styled(Box)({
  marginLeft: "16px",
});

export const FishingSpotShowView: React.FC<FishingSpotShowViewProps> = ({
  selectedLocation,
  onClose,
}) => {
  const [streetViewImageUrl, setStreetViewImageUrl] = useState<string | null>(
    null
  );
  const [isLoaded, setIsLoaded] = useState<boolean>(false);
  const [fishingSpot, setFishingSpot] = useState<FishingSpot | null>(null);

  const fetchStreetViewImage = useCallback(async () => {
    if (!selectedLocation) return;
    const response = await streetViewClient.fetchStreetViewImage(
      selectedLocation.latitude,
      selectedLocation.longitude
    );
    setStreetViewImageUrl(response);
  }, [selectedLocation]);

  const fetchFishingSpot = useCallback(async () => {
    if (!selectedLocation) return;
    const response = await showFishingSpot(selectedLocation.id);
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
        "& .MuiDrawer-paper": {
          width: DRAWER_WIDTH,
          boxSizing: "border-box",
        },
      }}
      anchor={"right"}
      variant='temporary'
      open={!!selectedLocation}
      onClose={() => {
        if (streetViewImageUrl) {
          URL.revokeObjectURL(streetViewImageUrl);
        }
        onClose();
      }}
    >
      <Stack spacing={3} useFlexGap>
        <Box sx={{ height: "400px" }}>
          {isLoaded ? (
            <img
              src={streetViewImageUrl ?? undefined}
              alt='street view image'
              style={{ width: "100%", height: "100%", objectFit: "cover" }}
            />
          ) : (
            <CenteredLoader />
          )}
        </Box>
        <FishingSpotBox>
          <Typography variant='h5' sx={{ fontWeight: 600 }} gutterBottom>
            {fishingSpot?.name}
          </Typography>
          <Stack direction='row' spacing={2}>
            <LocationOnIcon />
            <Typography variant='body1'>{fishingSpot?.address}</Typography>
          </Stack>
        </FishingSpotBox>
        <Divider />
        <FishingSpotBox>
          <Typography variant='subtitle1' sx={{ fontWeight: 600 }} gutterBottom>
            説明
          </Typography>
          <Typography variant='subtitle1'>{fishingSpot?.description}</Typography>
        </FishingSpotBox>
        <Divider />
        <FishingSpotBox>
          <Typography variant='subtitle1' sx={{ fontWeight: 600 }} gutterBottom>
            釣れる魚
          </Typography>
          <Stack direction='row' spacing={1}>
            {fishingSpot?.fishes.map((fish) => (
              <Chip key={fish.id} label={fish.name} color='primary' />
            ))}
          </Stack>
        </FishingSpotBox>
        <Divider />
        <FishingSpotBox>
          <Typography variant='subtitle1' sx={{ fontWeight: 600 }} gutterBottom>
            写真
          </Typography>
          <PhotoProvider
            toolbarRender={({ rotate, onRotate, onScale, scale }) => {
              return (
                <>
                  <Stack direction="row" spacing={1} alignItems="center">
                    <ZoomInIcon onClick={() => onScale(scale + 1)} sx={{ cursor: 'pointer' }} />
                    <ZoomOutIcon onClick={() => onScale(scale - 1)} sx={{ cursor: 'pointer' }} />
                    <RotateRightIcon onClick={() => onRotate(rotate + 90)} sx={{ cursor: 'pointer' }} />
                    <RotateLeftIcon onClick={() => onRotate(rotate - 90)} sx={{ cursor: 'pointer' }} />
                  </Stack>
                </>
              );
            }}
          >
          <Grid
            container
            spacing={{ xs: 2, md: 3 }}
            columns={{ xs: 8, sm: 12, md: 12 }}
            sx={{ margin: 3 }}
          >
            {fishingSpot?.images.map((image, index) => (
              <Grid item xs={4} sm={4} md={4} sx={{ display: "flex", justifyContent: "start", alignItems: "center", margin: 0}}>
                <PhotoView
                  key={index}
                  src={image.presigned_url}
                >
                  <Card
                    sx={{ width: "100%", height: "150px", objectFit: "cover", cursor: "pointer" }}
                  >
                    <img
                      src={image.presigned_url}
                      alt={image.file_name}
                      style={{ width: "100%", height: "100%", objectFit: "cover", cursor: "pointer" }}
                    />
                  </Card>
                </PhotoView>
              </Grid>
            ))}
          </Grid>
          </PhotoProvider>
        </FishingSpotBox>
      </Stack>
    </Drawer>
  );
};
