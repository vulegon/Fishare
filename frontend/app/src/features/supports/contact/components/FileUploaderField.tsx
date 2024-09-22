import React from 'react'
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import IconButton from '@mui/material/IconButton';
import CancelIcon from '@mui/icons-material/Cancel';

interface FileUploaderFieldProps {
  images: File[];
  setImages: React.Dispatch<React.SetStateAction<File[]>>;
}

// 下記を参考にして作成
// https://tsukurue.com/archives/301
export const FileUploaderField: React.FC<FileUploaderFieldProps> = (props: FileUploaderFieldProps) => {
  const MAX_IMAGES = 9;
  const handleOnAddFile = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files) return;
    const files: File[] = []

    // 現在の画像数とアップロードされたファイルの数をチェック
    const remainingSlots = MAX_IMAGES - props.images.length;

    for (let i = 0; i < Math.min(e.target.files.length, remainingSlots); i++) {
      files.push(e.target.files[i]);
    }
    props.setImages([...props.images, ...files]);
    e.target.value = '';
  }

  const handleOnDeleteFile = (index: number) => {
    const newImages = [...props.images];
    newImages.splice(index, 1);
    props.setImages(newImages);
  }

  return (
    <Grid container spacing={2} sx={{ border: '1px solid #ddd', padding: 2 }}>
      <Grid item xs={3} sx={{ backgroundColor: '#EBF5FF', padding: 2 }}>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <Typography variant="body1" sx={{ fontWeight: 'bold' }}>
            添付ファイル(最大{MAX_IMAGES}枚まで)
          </Typography>
        </Box>
      </Grid>
      <Grid item xs={9}>
        <label htmlFor="file-upload">
          <input
            id="file-upload"
            type="file"
            style={{ display: 'none' }}
            accept="image/*,.png,.jpg,.jpeg,.gif"
            onChange={(e: React.ChangeEvent<HTMLInputElement>) => { handleOnAddFile(e) }}
            multiple
          />
          <Button variant="contained" component="span" disabled={props.images.length >= MAX_IMAGES }>
            ファイルを選択
          </Button>
        </label>
        <Box sx={{height: '2rem'}}></Box>
        <Grid container spacing={{ xs: 2, md: 3 }} columns={{ xs: 8, sm: 12, md: 12 }} sx={{margin: 0}}>
          {props.images.map((image, index) => (
            <Grid
              item
              xs={4}
              sm={4}
              md={4}
              key={index}
              sx={{
                display: 'flex',
                justifyContent: 'start',
                alignItems: 'center',
                position: 'relative',
                margin: 0
              }}
            >
              <IconButton
                area-label="画像削除"
                style={{ position: 'absolute', top: 10, right: 0, color: '#aaa' }}
                onClick={() => { handleOnDeleteFile(index) }}
              >
                <CancelIcon/>
              </IconButton>
              <img
                src={URL.createObjectURL(image)}
                alt="アップロード済み画像"
                style={{
                  width: '100%',
                  height: '100%',
                  objectFit: 'contain',
                  aspectRatio: '1/1',
                }}
              />
            </Grid>
          ))}
        </Grid>
      </Grid>
    </Grid>
  )
}
