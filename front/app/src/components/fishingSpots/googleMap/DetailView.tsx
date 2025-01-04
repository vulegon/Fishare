import LocationOnIcon from "@mui/icons-material/LocationOn";
import {
  Box,
  Chip,
  Divider,
  Drawer,
  Grid,
  Stack,
  Typography,
  Card,
  Tooltip,
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
import CloseIcon from '@mui/icons-material/Close';
import FileCopyIcon from '@mui/icons-material/FileCopy';
import IconButton from '@mui/material/IconButton';
import { HEADER_HEIGHT } from 'constants/index';
import { Label } from "features/admin/fishingSpots/map/new/";
import InfoIcon from "@mui/icons-material/Info";
import { faFish } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import AddAPhotoIcon from '@mui/icons-material/AddAPhoto';
import EditIcon from '@mui/icons-material/Edit';
import { useUser } from "contexts/UserContext";

interface FishingSpotShowViewProps {
  selectedLocation: FishingSpotLocation | null;
  onClose: () => void;
  isAdminPage?: boolean;
}

const DRAWER_WIDTH = "500px";

const FishingSpotBox = styled(Box)({
  marginLeft: "16px",
});

export const DetailView: React.FC<FishingSpotShowViewProps> = ({
  selectedLocation,
  onClose,
  isAdminPage = false,
}) => {
  const [streetViewImageUrl, setStreetViewImageUrl] = useState<string | null>(null);
  const [isLoaded, setIsLoaded] = useState<boolean>(false);
  const [fishingSpot, setFishingSpot] = useState<FishingSpot | null>(null);
  const [tooltipOpen, setTooltipOpen] = useState(false);
  const { user } = useUser();

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

  const handleCopyUrl = async () => {
    try {
      await navigator.clipboard.writeText(window.location.href);
      setTooltipOpen(true);
      setTimeout(() => setTooltipOpen(false), 2000); // 2秒後にツールチップを非表示
    } catch (error) {
      console.error("URLのコピーに失敗しました", error);
      alert("URLのコピーに失敗しました");
    }
  };

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
      ModalProps={{
        BackdropProps: { invisible: true },
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
      <Stack spacing={2} useFlexGap>
        <Box sx={{ height: "400px" }}>
          {isLoaded ? (
            <>
              <img
                src={streetViewImageUrl ?? undefined}
                alt='street view image'
                style={{ width: "100%", height: "100%", objectFit: "cover" }}
              />
              <IconButton
                onClick={onClose}
                sx={{
                  position: "absolute",
                  top: HEADER_HEIGHT + 5,
                  right: 8,
                  backgroundColor: "rgba(255, 255, 255, 0.8)",
                  "&:hover": {
                    backgroundColor: "rgba(255, 255, 255, 1)",
                  },
                }}
              >
                <CloseIcon />
              </IconButton>
              <IconButton
                onClick={() => {
                  const currentUrl = window.location.href; // 現在のURLを取得
                  navigator.clipboard.writeText(currentUrl)
                }}
                sx={{
                  position: "absolute",
                  top: HEADER_HEIGHT + 5,
                  right: 60,
                  backgroundColor: "rgba(255, 255, 255, 0.8)",
                  "&:hover": {
                    backgroundColor: "rgba(255, 255, 255, 1)",
                  },
                }}
              >
                <Tooltip
                  title="URLをコピーしました！"
                  open={tooltipOpen}
                  placement="top"
                  arrow
                >
                  <FileCopyIcon onClick={handleCopyUrl}/>
                </Tooltip>
              </IconButton>
              { user?.isAdmin && isAdminPage && (
                <IconButton
                  onClick={onClose}
                  sx={{
                    position: "absolute",
                    top: HEADER_HEIGHT + 5,
                    right: 112,
                    backgroundColor: "rgba(255, 255, 255, 0.8)",
                    "&:hover": {
                      backgroundColor: "rgba(255, 255, 255, 1)",
                    },
                  }}
                >
                  <EditIcon />
                </IconButton>
              )}
            </>
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
          <Box>
            <Label label={"説明"} icon={<InfoIcon />} />
            <Typography variant='subtitle1'>{fishingSpot?.description}</Typography>
          </Box>
        </FishingSpotBox>
        <Divider />
        <FishingSpotBox>
          <Label
            label={"釣れる魚"}
            icon={
              <FontAwesomeIcon
                icon={faFish}
                style={{ fontSize: "23px" }}
              />
            }
          />
          <Stack direction='row' spacing={1}>
            {fishingSpot?.fishes.map((fish) => (
              <Chip key={fish.id} label={fish.name} color='primary' />
            ))}
          </Stack>
        </FishingSpotBox>
        <Divider />
        <FishingSpotBox>
          <Label label={'写真'} icon={<AddAPhotoIcon />} />
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
