import {
  Box,
  Button,
  Card,
  CardContent,
  CardMedia,
  Chip,
  Container,
  FormControl,
  Grid,
  InputLabel,
  MenuItem,
  Pagination,
  Paper,
  Select,
  Stack,
  TextField,
  Typography,
} from "@mui/material";
import { getFish } from "api/v1/fish";
import { getPrefectures } from "api/v1/prefectures";
import { FishingSpotFishSelecter } from "components/fishingSpots/FishingSpotFishSelecter";
import { Fish, Prefecture } from "interfaces/api";
import React, { useEffect, useState } from "react";
import { FormProvider, useForm } from "react-hook-form";
import { SearchFishingSpot } from "interfaces/api/fishingSpots/SearchFishingSpot";
import { searchFishingSpot } from "api/v1/fishingSpots";

export const SearchFishingSpots: React.FC = () => {
  const [prefectures, setPrefectures] = useState<Prefecture[]>([]);
  const [fishes, setFishes] = useState<Fish[]>([]);

  const useFormMethods = useForm({
    defaultValues: {
      name: "",
      prefecture_id: "",
      // fishes: [] as Fish[],
    },
  });

  const {
    handleSubmit,
    register,
    setValue,
    watch,
    formState: { isValid },
  } = useFormMethods;

  const fishingSpots = [
    {
      id: 1,
      name: "川尻港",
      description:
        "茨城県日立市にある川尻港は2本の堤防からなる中規模漁港。海底は岩礁帯や砂地が入り混じっており、砂地を好むハゼ、キス、カ…",
      tags: ["トイレ設備あり", "ファミリー向け", "外灯設備あり", "駐車場あり"],
      area: "茨城/北茨城-日立エリア",
      imageUrl: "https://via.placeholder.com/300x200",
    },
    {
      id: 2,
      name: "大津漁港",
      description:
        "茨城県北茨城市にある大津漁港は大小複数の堤防からなる巨大漁港。漁港内には堤防だけでなく、車を横付けして湾内釣りができ…",
      tags: [
        "トイレ設備あり",
        "ファミリー向け",
        "外灯設備あり",
        "近辺に釣具店",
        "駐車場あり",
      ],
      area: "茨城/北茨城-日立エリア",
      imageUrl: "https://via.placeholder.com/300x200",
    },
  ];

  const onSubmit = async (data: SearchFishingSpot) => {
    try {
      const res = await searchFishingSpot(data);
    } catch (error) {
      console.error(error);
    }
  };

  const fetchPrefectures = async () => {
    const res = await getPrefectures();
    setPrefectures(res.prefectures);
  };
  const fetchFish = async () => {
    const res = await getFish();
    setFishes(res.fishes);
  };

  useEffect(() => {
    fetchPrefectures();
    fetchFish();
  }, []);

  const handleSearch = () => {
    console.log("検索ボタンがクリックされました");
  };

  return (
    <Container maxWidth='lg' sx={{ mt: 4 }}>
      <Paper
        elevation={1}
        sx={{
          padding: "24px",
          borderRadius: "12px",
          backgroundColor: "rgba(247, 247, 247, 0.1)",
        }}
      >
        <Typography
          variant='h4'
          sx={{ fontWeight: "bold", textAlign: "center", mb: 1 }}
        >
          釣り場検索
        </Typography>
        <FormProvider {...useFormMethods}>
          <form onSubmit={handleSubmit(onSubmit)}>
            <Stack spacing={1}>
              <Grid container spacing={3}>
                <Grid item xs={12} md={6}>
                  <Typography variant='body1' sx={{ fontWeight: "bold", mb: 1 }}>
                    釣り場名
                  </Typography>
                  <TextField
                    placeholder='例: 九頭竜川'
                    {...register("name")}
                    fullWidth
                    variant='outlined'
                    label='釣り場名'
                  />
                </Grid>
                <Grid item xs={12} md={5.5}>
                  <Typography variant='body1' sx={{ fontWeight: "bold", mb: 1 }}>
                    都道府県
                  </Typography>
                  <FormControl fullWidth variant='outlined'>
                    <InputLabel>都道府県</InputLabel>
                    <Select
                      value={
                        prefectures.find((prefecture) => prefecture.id === watch("prefecture_id"))
                          ?.name || "" // 選択された都道府県名を表示
                      }
                      onChange={(e) =>{
                        const selectedPrefecture = prefectures.find(
                          (prefecture) => prefecture.name === e.target.value
                        );
                        if (selectedPrefecture) {
                          setValue("prefecture_id", selectedPrefecture.id);
                        }
                      }}
                      MenuProps={{
                        PaperProps: {
                          style: {
                            maxHeight: 300, // ドロップダウンの最大高さ
                            overflow: "auto", // スクロールを有効化
                          },
                        },
                      }}
                    >
                      {prefectures.map((prefecture) => (
                        <MenuItem key={prefecture.id} value={prefecture.name}>
                          {prefecture.name}
                        </MenuItem>
                      ))}
                    </Select>
                  </FormControl>
                </Grid>
              </Grid>

              <Grid container spacing={3}>
                {/* <Grid item xs={12} md={6}>
                  <Typography variant='body1' sx={{ fontWeight: "bold", mb: 1 }}>
                    釣れる魚
                  </Typography>
                  <FishingSpotFishSelecter name='fishes' fish={fishes} />
                </Grid> */}
              </Grid>
              <Box display='flex' justifyContent='flex-end' mt={2}>
                <Button
                  type='submit'
                  variant='contained'
                  color='primary'
                  size='large'
                  onClick={handleSearch}
                  sx={{
                    px: 4,
                    py: 1.5,
                    fontSize: "16px",
                    borderRadius: "24px",
                  }}
                >
                  検索する
                </Button>
              </Box>
            </Stack>
          </form>
        </FormProvider>
      </Paper>

      <Box mt={4}>
        <Typography variant='h6' sx={{ fontWeight: "bold", mb: 2 }}>
          検索結果
        </Typography>
        <Grid container spacing={3}>
          {fishingSpots.map((spot) => (
            <Grid item xs={12} key={spot.id}>
              <Card
                elevation={2}
                sx={{
                  display: "flex",
                  flexDirection: "row",
                  borderRadius: "12px",
                  overflow: "hidden",
                }}
              >
                {/* 画像 */}
                <CardMedia
                  component='img'
                  sx={{ width: 300, height: 200 }}
                  image={spot.imageUrl}
                  alt={spot.name}
                />
                <CardContent sx={{ flex: 1 }}>
                  <Typography
                    variant='body2'
                    color='primary'
                    sx={{ fontWeight: "bold", mb: 1 }}
                  >
                    {spot.area}
                  </Typography>
                  <Box
                    sx={{ display: "flex", flexWrap: "wrap", gap: 1, mb: 2 }}
                  >
                    {spot.tags.map((tag, index) => (
                      <Chip
                        key={index}
                        label={tag}
                        sx={{
                          fontSize: "12px",
                          backgroundColor: "#f0f0f0",
                        }}
                      />
                    ))}
                  </Box>
                  <Typography variant='h6' sx={{ fontWeight: "bold", mb: 1 }}>
                    {spot.name}
                  </Typography>
                  <Typography variant='body2' color='textSecondary'>
                    {spot.description}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
        <Box sx={{ display: "flex", justifyContent: "center", mt: 4 }}>
          <Pagination count={6} color='primary' />
        </Box>
      </Box>
    </Container>
  );
};
