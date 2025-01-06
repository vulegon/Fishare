import React, { useCallback } from "react";
import {
  Button,
  Box,
  Typography,
  Stack,
  Drawer,
} from '@mui/material';
import { faFish } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { zodResolver } from "@hookform/resolvers/zod";
import InfoIcon from "@mui/icons-material/Info";
import MyLocationIcon from "@mui/icons-material/MyLocation";
import RoomIcon from "@mui/icons-material/Room";
import { fetchAddress } from "api/lib/libGoogle/geocodeClient";
import { getFish } from "api/v1/fish";
import { createFishingSpot } from "api/v1/fishingSpots";
import { getPrefectures } from "api/v1/prefectures";
import { isAxiosError } from "axios";
import { FileUploader } from "components/common/FileUploader";
import { InputTextField } from "components/common/InputTextField";
import { FishingSpotFishSelecter } from "components/fishingSpots/FishingSpotFishSelecter";
import { Label } from "features/admin/fishingSpots/map/new/";
import { Fish, Prefecture } from "interfaces/api";
import { CreateFishingSpot } from "interfaces/api/admin/fishingSpots/CreateFishingSpot";
import { useEffect, useState } from "react";
import { FormProvider, useForm } from "react-hook-form";
import { useNavigate } from "react-router-dom";
import { notifySuccess } from "utils/toast/notifySuccess";
import CloseIcon from '@mui/icons-material/Close';
import IconButton from '@mui/material/IconButton';
import { HEADER_HEIGHT } from 'constants/index';
import { streetViewClient } from "api/lib/libGoogle/streetViewClient";
import { BeatLoader } from 'react-spinners';
import { useGoogleMap } from 'features/fishingSpots/googleMap/context/GoogleMapContext';
import { fishingSpotSchema } from "schemas/fishingSpotSchema";
import { ConfirmDialog } from "components/common/ConfirmDialog";
import { DropResult } from "react-beautiful-dnd";

interface FishingSpotCreateModalProps {
  onClose: () => void;
  open: boolean;
}

const DRAWER_WIDTH = 500;

export const FishingSpotCreateDrawer: React.FC<FishingSpotCreateModalProps> = ({
  onClose,
  open
}) => {
  const [streetViewImageUrl, setStreetViewImageUrl] = useState<string | null>(null);
  const [isLoaded, setIsLoaded] = useState<boolean>(false);
  const [fish, setFish] = React.useState<Fish[]>([]);
  const navigate = useNavigate();
  const { newLocation, setNewLocation, fetchFishingSpotLocations } = useGoogleMap();
  const [isConfirmDialogOpen, setIsConfirmDialogOpen] = useState<boolean>(false);

  const useFormMethods = useForm({
    defaultValues: {
      name: "",
      description: "",
      location: {
        prefecture: { id: "", name: "" } as Prefecture,
        address: "",
        latitude: 0,
        longitude: 0,
      },
      images: [] as File[],
      fish: [] as Fish[],
    },
    resolver: zodResolver(fishingSpotSchema),
    mode: "onChange",
  });

  const {
    handleSubmit,
    setValue,
    watch,
    formState: { isValid, isSubmitting },
  } = useFormMethods;
  const images = watch("images");

  const onSubmit = async (data: CreateFishingSpot) => {
    try {
      await createFishingSpot(data);
      notifySuccess('釣り場を登録しました');
      useFormMethods.reset();
      setNewLocation(null);
      await fetchFishingSpotLocations();
      setIsConfirmDialogOpen(false);
      onClose();
    } catch (error) {
      console.error(error);
      if (isAxiosError(error) && error.response?.status === 401) {
        navigate("/admin/sign_in");
        return;
      }
    }
  };

  const fetchStreetViewImage = useCallback(async () => {
    if (!newLocation) return;
    const response = await streetViewClient.fetchStreetViewImage(
      newLocation.lat,
      newLocation.lng
    );
    setStreetViewImageUrl(response);
  }, [newLocation]);

  useEffect(() => {
    const fetchData = async () => {
      setIsLoaded(false);
      if (!newLocation) return;
      const addressResponse = await fetchAddress(newLocation.lat, newLocation.lng);
      const prefectureData = await getPrefectures();
      const findPrefecture = prefectureData.prefectures.find(
        (pref: Prefecture) => pref.name === addressResponse.prefecture
      );

      if (!findPrefecture) return;
      setValue("location", {
        prefecture: findPrefecture,
        address: addressResponse.address,
        latitude: newLocation.lat,
        longitude: newLocation.lng,
      });
    };

    const loadData = async () => {
      await fetchData(); // fetchDataの完了を待つ
      fetchStreetViewImage(); // fetchDataが完了したらfetchStreetViewImageを実行
      setIsLoaded(true); // 完了後にLoadingをtrueにする
    };

    loadData();
  }, [newLocation]);

  useEffect(() => {
    const fetchFish = async () => {
      const response = await getFish();
      setFish(response.fishes);
    };

    fetchFish();
  }, []);

  // 画像の追加処理
  const handleOnAddFile = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files) return;
    const files: File[] = [];
    const remainingSlots = 9 - images.length;

    for (let i = 0; i < Math.min(e.target.files.length, remainingSlots); i++) {
      files.push(e.target.files[i]);
    }

    setValue("images", [...images, ...files]);
    e.target.value = "";
  };

  // 画像の削除処理
  const handleOnDeleteFile = (index: number) => {
    const updatedImages = [...images];
    updatedImages.splice(index, 1);
    setValue("images", updatedImages);
  };

  const handleOnDragEnd = (result: DropResult) => {
    if (!result.destination) return; // ドロップ先がない場合は終了

    const reorderedFiles = Array.from(images); // 現在のファイルリストをコピー
    const [movedFile] = reorderedFiles.splice(result.source.index, 1); // 元の位置から削除
    reorderedFiles.splice(result.destination.index, 0, movedFile); // 新しい位置に挿入

    setValue("images", reorderedFiles);
  };

  return (
    <Drawer
      anchor="right"
      open={open}
      variant="persistent"
      sx={{
        width: DRAWER_WIDTH,
        flexShrink: 0,
        "& .MuiDrawer-paper": {
          width: DRAWER_WIDTH,
          boxSizing: "border-box"
        }
      }}
    >
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
          </>
        ) : (
          <div
            style={{
              display: 'flex',
              justifyContent: 'center',
              alignItems: 'center',
              height: '100%'
            }}
          >
            <BeatLoader size={20} color={'#1976D2'}/>
          </div>
        )}
      </Box>
      <Box
        sx={{
          padding: 4,
          overflowY: "auto",
          left:'unset'
        }}
      >
        <IconButton
          onClick={onClose}
          sx={{
            position: "absolute",
            top: 8,
            right: 8,
            color: (theme) => theme.palette.grey[500],
          }}
        >
          <CloseIcon />
        </IconButton>
        <Box
          sx={{
            display: "flex",
            flexDirection: "row",
            alignItems: "center",
            textAlign: "center",
            mb: 1,
          }}
        >
          <Typography variant='h5' gutterBottom sx={{ fontWeight: "bold" }}>
            釣り場の登録
          </Typography>
        </Box>

        <FormProvider {...useFormMethods}>
          <form onSubmit={handleSubmit(onSubmit)}>
            <Stack spacing={2}>
              <Stack spacing={3}>
                <Box>
                  <Label label={"釣り場の名前"} icon={<MyLocationIcon />} />
                  <InputTextField name={"name"} />
                </Box>

                <Box>
                  <Label label={"住所"} icon={<RoomIcon />} />
                  <InputTextField name='location.address' />
                </Box>

                <Box>
                  <FileUploader
                    name='images'
                    label='写真を追加'
                    handleOnAddFile={handleOnAddFile}
                    handleOnDeleteFile={handleOnDeleteFile}
                    handleOnDragEnd={handleOnDragEnd}
                  />
                </Box>

                <Box>
                  <Label
                    label={"釣れる魚"}
                    icon={
                      <FontAwesomeIcon
                        icon={faFish}
                        style={{ fontSize: "23px" }}
                      />
                    }
                  />
                  <FishingSpotFishSelecter name='fish' fish={fish} />
                </Box>

                <Box>
                  <Label label={"説明"} icon={<InfoIcon />} />
                  <InputTextField name='description' multiline rows={5} />
                </Box>
              </Stack>

              <Box sx={{ textAlign: "center", mt: 4 }}>
                <Stack direction="row" spacing={2}  sx={{ width: "100%" }}>
                  <Button
                    variant="outlined"
                    color="error"
                    size="large"
                    fullWidth
                    onClick={() => {
                      useFormMethods.reset();
                      onClose();
                    }}
                  >
                    キャンセル
                  </Button>
                  <Button
                    variant='contained'
                    color='primary'
                    size='large'
                    fullWidth
                    onClick={() => {
                      setIsConfirmDialogOpen(true);
                    }}
                    disabled={!isValid || isSubmitting || !isLoaded}
                  >
                    登録
                  </Button>
                </Stack>
              </Box>
            </Stack>
            <ConfirmDialog
              open={isConfirmDialogOpen}
              onClose={() => {
                setIsConfirmDialogOpen(false);
              }}
              handleExecute={handleSubmit(onSubmit)}
              content={"この内容で登録します。よろしいですか？"}
              executeButtonTitle={"登録"}
              disabled={!isValid || isSubmitting || !isLoaded}
            />
          </form>
        </FormProvider>
      </Box>
    </Drawer>
  );
};
