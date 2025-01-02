import React from "react";
import {
  Container,
  Typography,
  Card,
  CardMedia,
  Grid,
  Box,
  Divider,
  Stack,
  TableContainer,
  Table,
  TableRow,
  TableCell,
  TableBody,
  Paper,
  Chip
} from "@mui/material";

export const ShowFishingSpot: React.FC = () => {
  const fishingSpot = {
    name: "高須海浜公園",
    description:
      "高須海浜公園は、素晴らしい設備と美しい景色が楽しめる人気の釣り場です。",
    mainImage: "https://via.placeholder.com/800x400",
    images: [
      "https://via.placeholder.com/400", // 実際の画像URLに置き換えてください
      "https://via.placeholder.com/400",
    ],
    address: "〒123-4567 高知県高須市海岸通り123",
    fishes: [
      { name: "アジ", season: "春～夏", size: "小～中型" },
      { name: "サバ", season: "夏～秋", size: "中型" },
      { name: "イワシ", season: "通年", size: "小型" },
      { name: "タイ", season: "春～秋", size: "大型" },
      { name: "ヒラメ", season: "冬", size: "中～大型" },
    ],
  };

  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      <Stack spacing={2}>
        <Typography variant="h4" gutterBottom sx={{ mt: 4, fontWeight: "bold" }}>
          {fishingSpot.name}
        </Typography>
        <Divider/>

        <Box sx={{ mt: 4, mb: 4 }}>
          <Card>
            <CardMedia
              component="img"
              height="400"
              image={fishingSpot.mainImage}
              alt="釣り場のメイン画像"
            />
          </Card>
        </Box>

        <Typography variant="body1" gutterBottom>
          {fishingSpot.description}
        </Typography>

        <Box
          sx={{
            width: "100%",
            height: 50,
            backgroundColor: "primary.main",
            display: "flex",
            alignItems: "center",
          }}
        >
          <Typography variant="h5" color="white" sx={{ ml: 2, fontWeight: "bold" }}>
            釣り場のご案内
          </Typography>
        </Box>

        <Box
          sx={{
            width: "100%",
            height: 300,
            backgroundColor: "#e0e0e0",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          <Typography variant="body2">地図（ここにGoogle Mapなどを表示）</Typography>
        </Box>

        <TableContainer component={Paper} sx={{ mt: 4 }}>
        <Table>
          <TableBody>
            <TableRow>
              <TableCell
                sx={{
                  backgroundColor: "#FAF8F5",
                  fontWeight: "bold",
                  width: "30%",
                }}
              >
                名称
              </TableCell>
              <TableCell>{fishingSpot.name}</TableCell>
            </TableRow>
            <TableRow>
              <TableCell
                sx={{
                  backgroundColor: "#FAF8F5",
                  fontWeight: "bold",
                }}
              >
                住所
              </TableCell>
              <TableCell>
              {fishingSpot.address}
              </TableCell>
            </TableRow>

            <TableRow>
              <TableCell
                sx={{
                  backgroundColor: "#FAF8F5",
                  fontWeight: "bold",
                }}
              >
                釣れる魚
              </TableCell>
              <TableCell>
                {fishingSpot.fishes.map((fish)=>(
                <Chip label={fish.name} key={fish.name} sx={{mr:1}}/>
              ))}
              </TableCell>
            </TableRow>
          </TableBody>
        </Table>
      </TableContainer>

      <Box
          sx={{
            width: "100%",
            height: 50,
            backgroundColor: "primary.main",
            display: "flex",
            alignItems: "center",
          }}
        >
          <Typography variant="h5" color="white" sx={{ ml: 2, fontWeight: "bold" }}>
            画像
          </Typography>
        </Box>
        <Grid container spacing={2}>
          {fishingSpot.images.map((image, index) => (
            <Grid item xs={12} sm={6} md={4} key={index}>
              <Card>
                <CardMedia
                  component="img"
                  height="200"
                  image={image}
                  alt={`釣り場の画像 ${index + 1}`}
                />
              </Card>
            </Grid>
          ))}
        </Grid>
      </Stack>
    </Container>
  );
};
