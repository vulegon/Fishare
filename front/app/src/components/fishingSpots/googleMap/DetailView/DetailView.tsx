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
import { FishingSpot } from "interfaces/api";
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
import { Label } from "features/admin/fishingSpots/map/new/";
import InfoIcon from "@mui/icons-material/Info";
import { faFish } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import AddAPhotoIcon from '@mui/icons-material/AddAPhoto';
import EditIcon from '@mui/icons-material/Edit';
import { useUser } from "contexts/UserContext";
import { DetailIconButton } from "./DetailIconButton";
import DeleteIcon from '@mui/icons-material/Delete';
import { deleteFishingSpot } from "api/v1/fishingSpots";
import { notifySuccess } from "utils/toast/notifySuccess";
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import { Button } from "@mui/material";
import { useGoogleMap } from "features/fishingSpots/googleMap/context/GoogleMapContext";

interface FishingSpotShowViewProps {
  onClose: () => void;
  open: boolean;
  isAdminPage?: boolean;
}

const DRAWER_WIDTH = "500px";

const FishingSpotBox = styled(Box)({
  marginLeft: "16px",
});

export const DetailView: React.FC<FishingSpotShowViewProps> = ({
  onClose,
  open,
  isAdminPage = false,
}) => {
  const [streetViewImageUrl, setStreetViewImageUrl] = useState<string | null>(null);
  const [isLoaded, setIsLoaded] = useState<boolean>(false);
  const [fishingSpot, setFishingSpot] = useState<FishingSpot | null>(null);
  const [tooltipOpen, setTooltipOpen] = useState(false);
  const { user } = useUser();
  const [diaLogOpen, setDiaLogOpen] = React.useState(false);
  const { selectedExistLocation, fetchFishingSpotLocations } = useGoogleMap();

  const fetchStreetViewImage = useCallback(async () => {
    if (!selectedExistLocation) return;
    const response = await streetViewClient.fetchStreetViewImage(
      selectedExistLocation.latitude,
      selectedExistLocation.longitude
    );
    setStreetViewImageUrl(response);
  }, [selectedExistLocation]);

  const fetchFishingSpot = useCallback(async () => {
    if (!selectedExistLocation) return;
    const response = await showFishingSpot(selectedExistLocation.id);
    setFishingSpot(response);
  }, [selectedExistLocation]);

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
    if (!selectedExistLocation) return;

    const fetchData = async () => {
      await Promise.all([fetchStreetViewImage(), fetchFishingSpot()]);
      setIsLoaded(true);
    };

    fetchData();
  }, [selectedExistLocation]);

  const handleDelete = async () => {
    if (!selectedExistLocation) return;
    await deleteFishingSpot(selectedExistLocation.fishing_spot_id);
    notifySuccess("釣り場を削除しました");
    fetchFishingSpotLocations();
    setDiaLogOpen(false);
    onClose();
  }

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
      open={open}
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
              <DetailIconButton
                onClick={onClose}
                right={8}
                children={<CloseIcon />}
              />
              <DetailIconButton
                onClick={() => {
                  const currentUrl = window.location.href; // 現在のURLを取得
                  navigator.clipboard.writeText(currentUrl)
                }}
                right={60}
                children={
                  <Tooltip
                    title="URLをコピーしました！"
                    open={tooltipOpen}
                    placement="top"
                    arrow
                  >
                    <FileCopyIcon onClick={handleCopyUrl}/>
                  </Tooltip>
                }
              />
              { user?.isAdmin && isAdminPage && (
                <DetailIconButton
                  onClick={onClose}
                  right={112}
                  children={<EditIcon />}
                />
              )}

              { user?.isAdmin && isAdminPage && (
                <IconButton
                  onClick={() => setDiaLogOpen(true)}
                  sx={{
                    position: "absolute",
                    bottom: 20,
                    right: 20,
                    backgroundColor: "rgba(255, 0, 0, 0.8)", // 初期は赤色に
                    color: "white", // アイコンの色
                    "&:hover": {
                      backgroundColor: "rgba(255, 0, 0, 1)", // ホバー時に明るい赤
                    },
                    "&:active": {
                      backgroundColor: "rgba(200, 0, 0, 1)", // 押したときは濃い赤
                    },
                    transition: "background-color 0.3s ease", // 色のスムーズな変化
                    boxShadow: "0px 4px 10px rgba(255, 0, 0, 0.5)", // ボタンに立体感
                  }}
                >
                  <DeleteIcon />
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

      <Dialog
        open={diaLogOpen}
        onClose={() => setDiaLogOpen(false)}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogTitle id="fishing-spot-delete-dialog-title">
          確認画面
        </DialogTitle>
        <DialogContent>
          <DialogContentText id="fishing-spot-delete-dialog-description">
            削除すると元に戻すことはできません。本当に削除しますか？
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={()=> setDiaLogOpen(false) } autoFocus>キャンセル</Button>
          <Button onClick={handleDelete} color="error" variant="contained">削除</Button>
        </DialogActions>
      </Dialog>
    </Drawer>
  );
};
