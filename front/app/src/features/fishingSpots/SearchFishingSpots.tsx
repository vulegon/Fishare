import React, { useState, useEffect } from 'react';
import {
  Container,
  TextField,
  Select,
  MenuItem,
  InputLabel,
  FormControl,
  Grid,
  Paper,
  Typography,
  Button,
  Box,
  Stack,
  Autocomplete,
  Card,
  CardMedia,
  CardContent,
  Chip,
  Pagination,
} from '@mui/material';
import { getPrefectures } from 'api/v1/prefectures';
import { Prefecture } from 'interfaces/api';
import { getFish } from 'api/v1/fish';
import { Fish } from 'interfaces/api';

export const SearchFishingSpots: React.FC = () => {
  const [searchName, setSearchName] = useState('');
  const [searchPrefecture, setSearchPrefecture] = useState('');
  const allSpots = [
    { id: 1, name: '釣り場A', prefecture: '北海道' },
    { id: 2, name: '釣り場B', prefecture: '東京都' },
    // 追加のデータ...
  ];
  const [prefectures, setPrefectures] = useState<Prefecture[]>([]);
  const [fishes, setFishes] = useState<Fish[]>([]);

  const fishingSpots = [
    {
      id: 1,
      name: '川尻港',
      description:
        '茨城県日立市にある川尻港は2本の堤防からなる中規模漁港。海底は岩礁帯や砂地が入り混じっており、砂地を好むハゼ、キス、カ…',
      tags: ['トイレ設備あり', 'ファミリー向け', '外灯設備あり', '駐車場あり'],
      area: '茨城/北茨城-日立エリア',
      imageUrl: 'https://via.placeholder.com/300x200',
    },
    {
      id: 2,
      name: '大津漁港',
      description:
        '茨城県北茨城市にある大津漁港は大小複数の堤防からなる巨大漁港。漁港内には堤防だけでなく、車を横付けして湾内釣りができ…',
      tags: ['トイレ設備あり', 'ファミリー向け', '外灯設備あり', '近辺に釣具店', '駐車場あり'],
      area: '茨城/北茨城-日立エリア',
      imageUrl: 'https://via.placeholder.com/300x200',
    },
  ];
  const fetchFishingSpots = () => {
    // setFishingSpots(allSpots);
  };
  const  fetchPrefectures = async () => {
    const res = await getPrefectures();
    setPrefectures(res.prefectures);
  }
  const fetchFish = async () => {
    const res = await getFish();
    setFishes(res.fishes);
  }

  useEffect(() => {
    fetchPrefectures();
    fetchFish();
  }, [searchName, searchPrefecture]);

  const handleSearch = () => {
    console.log('検索ボタンがクリックされました');
  };

  return (
    <Container maxWidth="lg" sx={{ mt: 4 }}>
      <Paper
        elevation={1}
        sx={{
          padding: "24px",
          borderRadius: "12px",
          backgroundColor: "rgba(247, 247, 247, 0.5)",
        }}
      >
        <Typography variant="h4" sx={{ fontWeight: 'bold', textAlign: 'center', mb: 1 }}>
          釣り場検索
        </Typography>
        <Stack spacing={1}>
          <Grid container spacing={5}>
            <Grid item xs={12} md={6}>
              <Typography variant="body1" sx={{ fontWeight: 'bold', mb: 1 }}>
                釣り場名
              </Typography>
              <TextField
                placeholder="例: 九頭竜川"
                value={searchName}
                onChange={(e) => setSearchName(e.target.value)}
                fullWidth
                variant="outlined"
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <Typography variant="body1" sx={{ fontWeight: 'bold', mb: 1 }}>
                都道府県
              </Typography>
              <FormControl fullWidth variant="outlined">
                <InputLabel>都道府県</InputLabel>
                <Select
                  value={searchPrefecture}
                  onChange={(e) => setSearchPrefecture(e.target.value)}
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
            <Grid item xs={12} md={6}>
              <Typography variant="body1" sx={{ fontWeight: 'bold', mb: 1 }}>
                釣れる魚
              </Typography>
              <Autocomplete
                freeSolo
                id="search-fish-free-solo"
                disableClearable
                options={fishes.map((f) => ({ id: f.id, name: f.name }))}
                getOptionLabel={(option: {id: string , name: string } | string) =>
                  typeof option === 'string' ? option : option.name
                }
                renderTags={(value, getTagProps) =>
                  value.map((option, index) => (
                    <Chip
                      {...getTagProps({ index })}
                      key={option.id}
                      color="primary"
                      variant="outlined"
                      label={option.name}
                    />
                  ))
                }
                renderInput={(params) => (
                  <TextField
                    {...params}
                    label="魚種を検索"
                    variant="outlined"
                    placeholder="サバ"
                  />
                )}
              />
            </Grid>
          </Grid>
          <Box display="flex" justifyContent="flex-end" mt={2}>
            <Button
              variant="contained"
              color="primary"
              size="large"
              onClick={handleSearch}
              sx={{
                px: 4,
                py: 1.5,
                fontSize: '16px',
                borderRadius: '24px',
              }}
            >
              検索する
            </Button>
          </Box>
        </Stack>

      </Paper>

      <Box mt={4}>
        <Typography variant="h6" sx={{ fontWeight: 'bold', mb: 2 }}>
          検索結果
        </Typography>
        <Grid container spacing={3}>
        {fishingSpots.map((spot) => (
          <Grid item xs={12} key={spot.id}>
            <Card
              elevation={2}
              sx={{
                display: 'flex',
                flexDirection: 'row',
                borderRadius: '12px',
                overflow: 'hidden',
              }}
            >
              {/* 画像 */}
              <CardMedia
                component="img"
                sx={{ width: 300, height: 200 }}
                image={spot.imageUrl}
                alt={spot.name}
              />
              <CardContent sx={{ flex: 1 }}>
                <Typography
                  variant="body2"
                  color="primary"
                  sx={{ fontWeight: 'bold', mb: 1 }}
                >
                  {spot.area}
                </Typography>
                <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 1, mb: 2 }}>
                  {spot.tags.map((tag, index) => (
                    <Chip
                      key={index}
                      label={tag}
                      sx={{
                        fontSize: '12px',
                        backgroundColor: '#f0f0f0',
                      }}
                    />
                  ))}
                </Box>
                <Typography variant="h6" sx={{ fontWeight: 'bold', mb: 1 }}>
                  {spot.name}
                </Typography>
                <Typography variant="body2" color="textSecondary">
                  {spot.description}
                </Typography>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>
      <Box sx={{ display: 'flex', justifyContent: 'center', mt: 4 }}>
        <Pagination count={6} color="primary" />
      </Box>
      </Box>
    </Container>
  );
};
