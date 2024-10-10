import { Box, Card, CardContent, Typography, Grid } from '@mui/material';
import { Link } from 'react-router-dom';

interface DashboardCardProps {
  label: string;
  backGroundColor: string;
  path: string;
  icon?: React.ReactNode;
}

export const DashboardCard: React.FC<DashboardCardProps> = ({
  label,
  backGroundColor,
  path,
  icon
}) => {
  return (
    <Grid item xs={12} sm={6} md={5}>
      <Link to={path} style={{ textDecoration: 'none' }}>
        <Card
          sx={{
            padding: 2,
            borderRadius: 4,
            boxShadow: '0 8px 20px rgba(0,0,0,0.1)',
            background: backGroundColor,
            color: 'white',
            height: 300, // 高さを大きく設定
            position: 'relative', // アニメーションやアイコン用に位置を調整
            overflow: 'hidden',
            transition: 'transform 0.3s ease-in-out', // ホバー時のアニメーション
            '&:hover': {
              transform: 'scale(1.05)',
            },
          }}
        >
          <CardContent sx={{ position: 'relative', zIndex: 2 }}>
            {icon}
            <Typography variant="h5" component="div">
              {label}
            </Typography>
          </CardContent>

          {/* 背景にアイコンの装飾 */}
          <Box
            sx={{
              position: 'absolute',
              top: -30,
              right: -30,
              width: 100,
              height: 100,
              backgroundColor: 'rgba(255,255,255,0.15)',
              borderRadius: '50%',
              zIndex: 1,
            }}
          />
        </Card>
      </Link>
    </Grid>
  );
};
