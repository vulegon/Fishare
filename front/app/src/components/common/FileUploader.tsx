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
import { DragDropContext, Droppable, Draggable, DropResult } from "react-beautiful-dnd";

interface FileUploaderProps {
  name: string;
  label?: string;
  icon?: JSX.Element;
  handleOnAddFile: (e: React.ChangeEvent<HTMLInputElement>) => void;
  handleOnDeleteFile: (index: number) => void;
  handleOnDragEnd: (result: DropResult) => void; // ここを追加
}

export const FileUploader: React.FC<FileUploaderProps> = (
  {
    name,
    label = "画像",
    icon = <AddAPhotoIcon />,
    handleOnAddFile,
    handleOnDeleteFile,
    handleOnDragEnd
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
        <label htmlFor="file-upload">
          <input
            id="file-upload"
            type="file"
            style={{ display: "none" }}
            accept="image/*,.png,.jpg,.jpeg,.gif"
            onChange={handleOnAddFile}
            multiple
          />
          <Button variant="contained" component="span">
            ファイルを選択
          </Button>
        </label>
      </Box>
      <Controller
        name={name}
        control={control}
        render={({ field }) => (
          <>
            <DragDropContext onDragEnd={handleOnDragEnd}>
              <Droppable droppableId="drop-images" direction="horizontal">
                {(provided) => (
                  <Grid
                    container
                    spacing={2}
                    {...provided.droppableProps}
                    ref={provided.innerRef}
                    sx={{ margin: 3 }}
                  >
                    {field.value.map((image: File, index: number) => (
                      <Draggable
                        key={index}
                        draggableId={`image-${index}`}
                        index={index}
                      >
                        {(provided) => (
                          <Grid
                            item
                            xs={4}
                            sm={4}
                            md={4}
                            sx={{
                              display: "flex",
                              justifyContent: "start",
                              alignItems: "center",
                              position: "relative",
                            }}
                            ref={provided.innerRef}
                            {...provided.draggableProps}
                            {...provided.dragHandleProps}
                          >
                            <IconButton
                              area-label="画像削除"
                              style={{
                                position: "absolute",
                                top: 10,
                                right: 0,
                                color: "#aaa",
                              }}
                              onClick={() => handleOnDeleteFile(index)}
                            >
                              <CancelIcon />
                            </IconButton>
                            <img
                              src={URL.createObjectURL(image)}
                              alt="アップロード済み画像"
                              style={{
                                width: "100%",
                                height: "100%",
                                objectFit: "contain",
                                aspectRatio: "1/1",
                              }}
                            />
                          </Grid>
                        )}
                      </Draggable>
                    ))}
                    {provided.placeholder}
                  </Grid>
                )}
              </Droppable>
            </DragDropContext>
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
