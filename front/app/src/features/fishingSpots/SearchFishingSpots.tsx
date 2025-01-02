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
import { Fish, Prefecture } from "interfaces/api";
import React, { useEffect, useState } from "react";
import { FormProvider, useForm } from "react-hook-form";
import { SearchFishingSpot } from "interfaces/api/fishingSpots/SearchFishingSpot";
import { searchFishingSpot } from "api/v1/fishingSpots";
import { SearchFishingSpotResponse } from "interfaces/api/fishingSpots/SearchFishingSpotResponse";
import { SelectChangeEvent } from "@mui/material";
import { useSearchParams } from "react-router-dom";
import { CenteredLoader } from "components/common";
import { useNavigate } from "react-router-dom";

export const SearchFishingSpots: React.FC = () => {
  const [prefectures, setPrefectures] = useState<Prefecture[]>([]);
  const [fishes, setFishes] = useState<Fish[]>([]);
  const [searchResult, setSearchResult] = useState<SearchFishingSpotResponse | null>(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(10);
  const [searchParams, setSearchParams] = useSearchParams();
  const navigate = useNavigate();

  const useFormMethods = useForm({
    defaultValues: {
      name: "",
      prefecture_id: "",
      offset: 0,
      limit: 10,
    },
  });

  const {
    handleSubmit,
    register,
    setValue,
    watch,
    formState: { isValid, isSubmitting },
  } = useFormMethods;

  const onSubmit = async (data: SearchFishingSpot) => {
    try {
      const requestData = {
        ...data,
        offset: (currentPage - 1) * itemsPerPage,
        limit: itemsPerPage,
      };
      setSearchParams({
        name: encodeURIComponent(data.name || ""),
        prefecture_id: requestData.prefecture_id || "",
        offset: requestData.offset.toString(),
        limit: requestData.limit.toString(),
      });

      const res = await searchFishingSpot(requestData);
      setSearchResult(res);
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

  const handlePageChange = async (event: React.ChangeEvent<unknown>, value: number) => {
    setCurrentPage(value);
  };

  const handleLimitChange = async (event: SelectChangeEvent<number>) => {
    const value = Number(event.target.value); // 値を数値に変換
    console.log(value);
    setItemsPerPage(value); // 表示件数を更新
    setCurrentPage(1);
  }

  const onCardClick = (id: string) => {
    navigate(`/fishing_spots/${id}`);
  }

  useEffect(() => {
    fetchPrefectures();
    fetchFish();

    const initialValues = {
      name: decodeURIComponent(searchParams.get("name") || ""),
      prefecture_id: searchParams.get("prefecture_id") || "",
      offset: parseInt(searchParams.get("offset") || "0", 10),
      limit: parseInt(searchParams.get("limit") || "10", 10),
    };

    // フォームの初期値を設定
    useFormMethods.reset(initialValues);

    // 初期検索を実行
    onSubmit(initialValues);
  }, []);

  useEffect(() => {
    onSubmit({
      ...useFormMethods.getValues(),
      offset: (currentPage - 1) * itemsPerPage,
      limit: itemsPerPage,
    });
  }, [currentPage, itemsPerPage]);

  if (isSubmitting) {
    // ローディング中にCenteredLoaderを表示
    return <CenteredLoader />;
  }

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
                <Grid item xs={12} md={5.8}>
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
                <Grid item xs={12} md={5.8}>
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
                  disabled={isSubmitting}
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
      <Box display="flex" justifyContent="space-between" mb={2}>
        <Typography variant="h6" sx={{ mb: 2, fontWeight: "bold" }}>
          検索結果 {searchResult?.count || 0} 件
        </Typography>
        <FormControl variant="outlined" sx={{ minWidth: 120 }}>
          <InputLabel id="items-per-page-label">表示件数</InputLabel>
          <Select
            labelId="items-per-page-label"
            value={itemsPerPage}
            onChange={handleLimitChange}
          >
            {[10, 25, 50].map((count) => (
              <MenuItem key={count} value={count}>
                {count} 件
              </MenuItem>
            ))}
          </Select>
        </FormControl>
      </Box>
        <Grid container spacing={3}>
          {searchResult?.fishingSpots.map((spot) => (
            <Grid item xs={12} key={spot.id}>
              <Card
                id={spot.id}
                elevation={2}
                onClick={() => onCardClick(spot.id)}
                sx={{
                  display: "flex",
                  flexDirection: "row",
                  borderRadius: "12px",
                  overflow: "hidden",
                  height: 200,
                  cursor: "pointer",
                  transition: "transform 0.3s ease", // なめらかな拡大縮小のアニメーション
                  "&:hover": {
                    transform: "scale(1.05)", // ホバー時にカードを少し大きくする
                    boxShadow: "0px 8px 16px rgba(0, 0, 0, 0.2)", // ホバー時の影を強調
                  },
                }}
              >
                {/* 画像 */}
                <CardMedia
                  component='img'
                  sx={{
                    width: 300,
                    height: 200,
                    objectFit: "contain",
                    backgroundColor: "#f0f0f0",
                  }}
                  image={spot.images[0]?.presigned_url || "https://via.placeholder.com/300x200"}
                  alt={spot.name}
                />
                <CardContent sx={{ flex: 1 }}>
                  <Typography
                    variant='body2'
                    color='primary'
                    sx={{ fontWeight: "bold", mb: 1 }}
                  >
                    {spot.locations[0].prefecture.name}
                  </Typography>
                  <Box
                    sx={{ display: "flex", flexWrap: "wrap", gap: 1, mb: 2 }}
                  >
                    {spot.fishes.length > 0 && spot.fishes.map((fish, index) => (
                      <Chip
                        key={index}
                        label={fish.name}
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
          <Pagination
            count={Math.ceil((searchResult?.count || 0) / itemsPerPage)}
            page={currentPage}
            onChange={handlePageChange}
            color="primary"
          />
        </Box>
      </Box>
    </Container>
  );
};
