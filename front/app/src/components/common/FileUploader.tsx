import React from "react";
import {
  Box,
  Button,
  Grid,
  IconButton,
  Typography,
  Stack
} from "@mui/material";
import CancelIcon from "@mui/icons-material/Cancel";
import AddAPhotoIcon from '@mui/icons-material/AddAPhoto';
import { Controller, useFormContext } from "react-hook-form";
import { Label } from 'features/admin/fishingSpots/map/new'

interface FileUploaderProps {
  name: string;
  label?: string;
  icon?: JSX.Element;
  handleOnAddFile: (e: React.ChangeEvent<HTMLInputElement>) => void;
  handleOnDeleteFile: (index: number) => void;
}

export const FileUploader: React.FC<FileUploaderProps> = (
  {
    name,
    label = "画像",
    icon = <AddAPhotoIcon />,
    handleOnAddFile,
    handleOnDeleteFile
  }
) => {
  const {
    control,
    formState: { errors },
  } = useFormContext();

  return (
    <Stack spacing={1}>
      <Box>
        <Label label={label} icon={icon} />
        <label htmlFor='file-upload'>
          <input
            id='file-upload'
            type='file'
            style={{ display: "none" }}
            accept='image/*,.png,.jpg,.jpeg,.gif'
            onChange={(e: React.ChangeEvent<HTMLInputElement>) => { handleOnAddFile(e) }}
            multiple
          />
          <Button variant='contained' component='span'>
            ファイルを選択
          </Button>
        </label>
      </Box>
      <Controller
        name={name}
        control={control}
        render={({ field }) => (
          <>
            <Grid
              container
              spacing={{ xs: 2, md: 3 }}
              columns={{ xs: 8, sm: 12, md: 12 }}
              sx={{ margin: 3 }}
            >
              {field.value.map((image: File, index: number) => (
                <Grid
                  item
                  xs={4}
                  sm={4}
                  md={4}
                  key={index}
                  sx={{
                    display: "flex",
                    justifyContent: "start",
                    alignItems: "center",
                    position: "relative",
                    margin: 0,
                  }}
                >
                  <IconButton
                    area-label='画像削除'
                    style={{
                      position: "absolute",
                      top: 10,
                      right: 0,
                      color: "#aaa",
                    }}
                    onClick={() => { handleOnDeleteFile(index) }}
                  >
                    <CancelIcon />
                  </IconButton>
                  <img
                    src={URL.createObjectURL(image)}
                    alt='アップロード済み画像'
                    style={{
                      width: "100%",
                      height: "100%",
                      objectFit: "contain",
                      aspectRatio: "1/1",
                    }}
                  />
                </Grid>
              ))}
            </Grid>
            {errors.images && (
              <Typography color="error" variant="body2" sx={{ mt: 1 }}>
                {errors.images.message?.toString()}
              </Typography>
            )}
          </>
        )}
      />
    </Stack>
  );
};
