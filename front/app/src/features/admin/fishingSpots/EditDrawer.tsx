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
import { getPrefectures } from "api/v1/prefectures";
import { isAxiosError } from "axios";
import { FileUploader } from "components/common/FileUploader";
import { InputTextField } from "components/common/InputTextField";
import { FishingSpotFishSelecter } from "components/fishingSpots/FishingSpotFishSelecter";
import { Label } from "features/admin/fishingSpots/map/new/";
import { Fish, Prefecture } from "interfaces/api";
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
import { FishingSpot } from "interfaces/api/FishingSpot";
import { UpdateFishingSpot } from "interfaces/api/admin/fishingSpots/UpdateFishingSpot";
import { updateFishingSpot } from "api/v1/fishingSpots";
import { DropResult } from "react-beautiful-dnd";

interface FishingSpotCreateModalProps {
  fishingSpot : FishingSpot;
  onClose: () => void;
  open: boolean;
}

const DRAWER_WIDTH = 500;

export const EditDrawer: React.FC<FishingSpotCreateModalProps> = ({
  fishingSpot,
  onClose,
  open
}) => {
  const [streetViewImageUrl, setStreetViewImageUrl] = useState<string | null>(null);
  const [isLoaded, setIsLoaded] = useState<boolean>(false);
  const [fish, setFish] = React.useState<Fish[]>([]);
  const navigate = useNavigate();
  const { newLocation, setNewLocation, fetchFishingSpotLocations } = useGoogleMap();

  const useFormMethods = useForm({
    defaultValues: {
      name: fishingSpot.name,
      description: fishingSpot.description,
      location: {
        prefecture: { id: "", name: "" } as Prefecture,
        address: fishingSpot.address,
        latitude: fishingSpot.latitude,
        longitude: fishingSpot.longitude,
      },
      newImages: [] as File[],
      fish: fishingSpot.fishes,
      existImages: fishingSpot.images,
      imageOrders: fishingSpot.images.map((_, index) => ({ isNew: false, index }))
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
  const newImages = watch("newImages");
  const existImages = watch("existImages");
  const imageOrders = watch("imageOrders");

  const onSubmit = async (data: UpdateFishingSpot) => {
    try {
      await updateFishingSpot(data);
      notifySuccess('釣り場を更新しました');
      await fetchFishingSpotLocations();
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

  const handleOnAddFile = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files) return;

    const files: File[] = Array.from(e.target.files);
    const remainingSlots = 9 - (existImages.length + newImages.length);
    const filesToAdd = files.slice(0, remainingSlots);

    const newFileIndexes = filesToAdd.map((_, index) => ({
      isNew: true,
      index: newImages.length + index,
    }));

    setValue("newImages", [...newImages, ...filesToAdd]);
    setValue("imageOrders", [...imageOrders, ...newFileIndexes]);
    e.target.value = ""; // クリア
  };

  const handleOnDeleteFile = (index: number) => {
    const { isNew, index: targetIndex } = imageOrders[index];

    // 画像リストから削除
    if (isNew) {
      const updatedNewImages = [...newImages];
      updatedNewImages.splice(targetIndex, 1);
      setValue("newImages", updatedNewImages);
    } else {
      const updatedExistImages = [...existImages];
      updatedExistImages.splice(targetIndex, 1);
      setValue("existImages", updatedExistImages);
    }

    // 順序配列を更新
    const updatedOrder = imageOrders.filter((_, i) => i !== index).map((item) => {
      // 削除された要素以降のインデックスを調整
      if (item.isNew === isNew && item.index > targetIndex) {
        return { ...item, index: item.index - 1 };
      }
      return item;
    });

    setValue("imageOrders", updatedOrder);
  };

  const handleOnDragEnd = (result: DropResult) => {
    if (!result.destination) return; // ドロップ先がない場合は終了

    const reorderedOrder = Array.from(imageOrders); // 現在の順序をコピー
    const [movedItem] = reorderedOrder.splice(result.source.index, 1); // 元の位置から削除
    reorderedOrder.splice(result.destination.index, 0, movedItem); // 新しい位置に挿入

    setValue("imageOrders", reorderedOrder);
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
            釣り場の更新
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
                    type='submit'
                    variant='contained'
                    color='primary'
                    size='large'
                    fullWidth
                    onClick={handleSubmit(onSubmit)}
                    disabled={!isValid || isSubmitting || !isLoaded}
                  >
                    更新
                  </Button>
                </Stack>
              </Box>
            </Stack>
          </form>
        </FormProvider>
      </Box>
    </Drawer>
  );
};
