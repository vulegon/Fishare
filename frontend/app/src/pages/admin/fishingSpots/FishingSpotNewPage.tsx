import React, { useState, useEffect } from "react";
import {
  Box,
  Typography,
  Stack,
  Button,
} from "@mui/material";
import { MainLayout } from "features/layouts";
import Container from "@mui/material/Container";
import { useSearchParams } from "react-router-dom";
import {
  FishingSpotNewLoadMap,
  Label,
} from "features/admin/fishingSpots/map/new/";
import { fetchAddress } from "api/lib/libGoogle/geocodeClient";
import { Prefecture } from "interfaces/api";
import apiClient from "api/v1/apiClient";
import AdminApiClient from "api/v1/admin/adminApiClient";
import RoomIcon from "@mui/icons-material/Room";
import InfoIcon from "@mui/icons-material/Info";
import MapIcon from "@mui/icons-material/Map";
import { faFish } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import MyLocationIcon from "@mui/icons-material/MyLocation";
import { Fish } from "interfaces/api";
import * as z from 'zod';
import { zodResolver } from '@hookform/resolvers/zod';
import { FormProvider, useForm } from 'react-hook-form';
import { InputTextField } from "components/common/InputTextField";
import { FileUploader } from "components/common/FileUploader";
import { FishingSpotFishSelecter } from "features/admin/fishingSpots/map/new/FishingSpotFishSelecter";
import { CreateFishingSpot } from "interfaces/api/admin/fishingSpots/CreateFishingSpot";
import adminApiClient from "api/v1/admin/adminApiClient";
import { notifySuccess } from "utils/toast/notifySuccess";

const schema = z.object({
  name: z.string().min(2, '名前は2文字以上である必要があります').max(50, '名前は100文字以内で入力してください'),
  images: z.array(z.instanceof(File)).max(9, '画像は最大9枚までです'),
  prefecture: z.string().min(1, '都道府県を選択してください'),
  address: z.string().min(1, '住所を入力してください'),
  fish: z.array(z.string()).min(1, '釣れる魚を選択してください'),
  description: z.string().min(10, '説明は10文字以上入力してください'),
});

export const FishingSpotNewPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const lat = parseFloat(searchParams.get("lat") || "35.681236");
  const lng = parseFloat(searchParams.get("lng") || "139.767125");
  const [marker, setMarker] = useState<google.maps.LatLngLiteral>({ lat, lng });
  const [isLoaded, setIsLoaded] = useState<boolean>(false);
  const [fish, setFish] = React.useState<Fish[]>([]);

  const useFormMethods = useForm({
    defaultValues: {
      name: '',
      description: '',
      location: {
        prefecture: { id: '', name: '' } as Prefecture,
        address: '',
        latitude: 0,
        longitude: 0,
      },
      images: [] as File[],
      fish: [] as Fish[],
    },
    resolver: zodResolver(schema),
    mode: 'onChange'
  });

  const {
    handleSubmit,
    setValue,
    watch,
  } = useFormMethods;
  const images = watch('images');

  useEffect(() => {
    const fetchData = async () => {
      setIsLoaded(false);
      const addressResponse = await fetchAddress(marker.lat, marker.lng);
      const prefectureData = await apiClient.getPrefectures();
      const findPrefecture = prefectureData.prefectures.find(
        (pref: Prefecture) => pref.name === addressResponse.prefecture
      );

      if (!findPrefecture) return;
      setValue(
        'location',
        {
          prefecture: findPrefecture,
          address: addressResponse.address,
          latitude: marker.lat,
          longitude: marker.lng,
        }
      );
    };

    const loadData = async () => {
      await fetchData(); // fetchDataの完了を待つ
      setIsLoaded(true); // 完了後にLoadingをtrueにする
    };

    loadData();
  }, [marker]);

  useEffect(() => {
    const fetchFish = async () => {
      const response = await apiClient.getFish();
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

    setValue('images', [...images, ...files]);
    e.target.value = "";
  };

  // 画像の削除処理
  const handleOnDeleteFile = (index: number) => {
    const updatedImages = [...images];
    updatedImages.splice(index, 1);
    setValue('images', updatedImages);
  };

  const onSubmit = async (data: CreateFishingSpot) => {
    try {
      console.log(data);
      const res = await adminApiClient.createFishingSpot(data);
      notifySuccess(res.message);
    } catch (err) {
      console.error(err);
    }
  };

  return (
    <MainLayout>
      <Container fixed>
        <Box>
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
          </Box>

          <FormProvider {...useFormMethods}>
            <form onSubmit={handleSubmit(onSubmit)}>
              <Stack spacing={2}>
                <Box>
                  <Label label={"釣り場の場所"} icon={<MapIcon />} />
                  <Box
                    sx={{
                      borderRadius: 2,
                      overflow: "hidden",
                      boxShadow: 3,
                      width: "100%",
                      height: "400px",
                      minWidth: "500px",
                    }}
                  >
                    {marker && isLoaded && (
                      <FishingSpotNewLoadMap
                        marker={marker}
                        onMapClick={onMapClick}
                      />
                    )}
                  </Box>
                </Box>

                <Stack spacing={3}>
                  <Box>
                    <Label label={"釣り場の名前"} icon={<MyLocationIcon />} />
                    <InputTextField name={"name"}/>
                  </Box>

                  <Box>
                    <Label label={"住所"} icon={<RoomIcon />} />
                    <InputTextField name="location.address" />
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
                    <FishingSpotFishSelecter
                      name='fish'
                      fish={fish}
                    />
                  </Box>

                  <Box>
                    <Label label={"説明"} icon={<InfoIcon />} />
                    <InputTextField
                      name="description"
                      multiline
                      rows={5}
                    />
                  </Box>
                </Stack>

                <Box sx={{ textAlign: "center", mt: 4 }}>
                  <Button type='submit' variant='contained' color='primary' size='large'>
                    釣り場を登録する
                  </Button>
                </Box>
              </Stack>
            </form>
          </FormProvider>
        </Box>
      </Container>
    </MainLayout>
  );
};
