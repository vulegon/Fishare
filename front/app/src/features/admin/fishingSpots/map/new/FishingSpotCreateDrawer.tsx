import React from "react";
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
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
import {
  FishingSpotNewLoadMap,
  Label,
} from "features/admin/fishingSpots/map/new/";
import { MainLayout } from "features/layouts";
import { Fish, Prefecture } from "interfaces/api";
import { CreateFishingSpot } from "interfaces/api/admin/fishingSpots/CreateFishingSpot";
import { useEffect, useState } from "react";
import { FormProvider, useForm } from "react-hook-form";
import { useNavigate, useSearchParams } from "react-router-dom";
import { notifySuccess } from "utils/toast/notifySuccess";
import * as z from "zod";
import CloseIcon from '@mui/icons-material/Close';
import IconButton from '@mui/material/IconButton';
import { HEADER_HEIGHT } from 'constants/index';

interface FishingSpotCreateModalProps {
  newLocation: google.maps.LatLngLiteral;
  onClose: () => void;
  isDrawerOpen: boolean;
}

const schema = z.object({
  name: z
    .string()
    .min(2, "名前は2文字以上である必要があります")
    .max(50, "名前は100文字以内で入力してください"),
  images: z.array(z.instanceof(File)).max(9, "画像は最大9枚までです"),
  location: z.object({
    prefecture: z.object({
      id: z.string().nonempty("都道府県を選択してください"),
      name: z.string().nonempty("都道府県名を入力してください"),
    }),
    address: z.string().min(1, "住所を入力してください"),
    latitude: z.number(),
    longitude: z.number(),
  }),
  fish: z
    .array(
      z.object({
        id: z.string(),
        name: z.string(),
      })
    )
    .min(1, "釣れる魚を選択してください"),
  description: z.string().min(10, "説明は10文字以上入力してください"),
});

export const FishingSpotCreateDrawer: React.FC<FishingSpotCreateModalProps> = ({
  newLocation,
  onClose,
  isDrawerOpen,
}) => {
    const [searchParams] = useSearchParams();
    const lat = parseFloat(searchParams.get("lat") || "35.681236");
    const lng = parseFloat(searchParams.get("lng") || "139.767125");
    const [marker, setMarker] = useState<google.maps.LatLngLiteral>({ lat, lng });
    const [isLoaded, setIsLoaded] = useState<boolean>(false);
    const [fish, setFish] = React.useState<Fish[]>([]);
    const navigate = useNavigate();

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
      resolver: zodResolver(schema),
      mode: "onChange",
    });

    const {
      handleSubmit,
      setValue,
      watch,
      formState: { isValid },
    } = useFormMethods;
    const images = watch("images");

    const onSubmit = async (data: CreateFishingSpot) => {
      try {
        const res = await createFishingSpot(data);
        notifySuccess(res.message);
        navigate("/admin/fishing_spots/map/select");
      } catch (error) {
        console.error(error);
        if (isAxiosError(error) && error.response?.status === 401) {
          navigate("/admin/sign_in");
          return;
        }
      }
    };

    useEffect(() => {
      const fetchData = async () => {
        setIsLoaded(false);
        const addressResponse = await fetchAddress(marker.lat, marker.lng);
        const prefectureData = await getPrefectures();
        const findPrefecture = prefectureData.prefectures.find(
          (pref: Prefecture) => pref.name === addressResponse.prefecture
        );

        if (!findPrefecture) return;
        setValue("location", {
          prefecture: findPrefecture,
          address: addressResponse.address,
          latitude: marker.lat,
          longitude: marker.lng,
        });
      };

      const loadData = async () => {
        await fetchData(); // fetchDataの完了を待つ
        setIsLoaded(true); // 完了後にLoadingをtrueにする
      };

      loadData();
    }, [marker]);

    useEffect(() => {
      const fetchFish = async () => {
        const response = await getFish();
        setFish(response.fishes);
      };

      fetchFish();
    }, []);

    const onMapClick = (e: google.maps.MapMouseEvent) => {
      if (!e.latLng) return;
      setMarker({ lat: e.latLng.lat(), lng: e.latLng.lng() });
    };

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
  return (
    <>
      <Drawer
        anchor="right" // Drawerを右側に表示
        open={isDrawerOpen}
        ModalProps={{
          disablePortal: true,
          hideBackdrop: true, // バックドロップを非表示
        }}
      >
        <Box
          sx={{
            marginTop: `${HEADER_HEIGHT}px`,
            width: 500, // Drawerの幅
            padding: 4,
            overflowY: "auto",
            position: "relative",
            left:'unset'
          }}
        >
          <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              alignItems: "center",
              textAlign: "center",
              mt: 1,
              mb: 1,
            }}
          >
            <Typography variant='h4' gutterBottom sx={{ fontWeight: "bold" }}>
              釣り場登録
            </Typography>
            <IconButton
              onClick={onClose}
              sx={{
                position: "absolute", // 絶対位置指定で右上に配置
                top: 8,
                right: 8,
                color: (theme) => theme.palette.grey[500], // グレー色で目立ちすぎない
              }}
            >
              <CloseIcon />
            </IconButton>
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
                  <Button
                    type='submit'
                    variant='contained'
                    color='primary'
                    size='large'
                    onClick={handleSubmit(onSubmit)}
                    disabled={!isValid}
                  >
                    釣り場を登録する
                  </Button>
                </Box>
              </Stack>
            </form>
          </FormProvider>
        </Box>
      </Drawer>
    </>
  );
};
