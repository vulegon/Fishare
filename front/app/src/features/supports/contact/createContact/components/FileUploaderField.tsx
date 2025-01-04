import React from 'react';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import IconButton from '@mui/material/IconButton';
import CancelIcon from '@mui/icons-material/Cancel';
import { InputFieldLabel } from './InputFieldLabel';
import { DragDropContext, Droppable, Draggable, DropResult } from 'react-beautiful-dnd';

interface FileUploaderFieldProps {
  images: File[];
  handleOnAddFile: (e: React.ChangeEvent<HTMLInputElement>) => void;
  handleOnDeleteFile: (index: number) => void;
  activeStep: number;
  handleOnDragEnd: (result: DropResult) => void;
}

export const FileUploaderField: React.FC<FileUploaderFieldProps> = ({
  images,
  handleOnAddFile,
  handleOnDeleteFile,
  activeStep,
  handleOnDragEnd
}) => {
  const MAX_IMAGES = 9;

  return (
    <Grid container spacing={2} sx={{ border: '1px solid #ddd', padding: 2 }}>
      <InputFieldLabel label="添付ファイル" isRequired={false} />
      <Grid item xs={9}>
        {activeStep === 0 && (
          <label htmlFor="file-upload">
            <input
              id="file-upload"
              type="file"
              style={{ display: 'none' }}
              accept="image/*,.png,.jpg,.jpeg,.gif"
              onChange={handleOnAddFile}
              multiple
            />
            <Button
              variant="contained"
              component="span"
              disabled={images.length >= MAX_IMAGES}
            >
              ファイルを選択
            </Button>
          </label>
        )}
        <Box sx={{ height: '2rem' }}></Box>
        <DragDropContext onDragEnd={handleOnDragEnd}>
          <Droppable droppableId="support-contact-form-droppable" direction="horizontal">
            {(provided) => (
              <Grid
                container
                spacing={{ xs: 2, md: 3 }}
                columns={{ xs: 8, sm: 12, md: 12 }}
                ref={provided.innerRef}
                {...provided.droppableProps}
                sx={{ margin: 0 }}
              >
                {images.map((image, index) => (
                  <Draggable key={index.toString()} draggableId={index.toString()} index={index}>
                    {(provided) => (
                      <Grid
                        item
                        xs={4}
                        sm={4}
                        md={4}
                        ref={provided.innerRef}
                        {...provided.draggableProps}
                        {...provided.dragHandleProps}
                        sx={{
                          display: 'flex',
                          justifyContent: 'start',
                          alignItems: 'center',
                          position: 'relative',
                          margin: 0,
                        }}
                      >
                        {activeStep === 0 && (
                          <IconButton
                            aria-label="画像削除"
                            style={{ position: 'absolute', top: 10, right: 0, color: '#aaa' }}
                            onClick={() => handleOnDeleteFile(index)}
                          >
                            <CancelIcon />
                          </IconButton>
                        )}
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
                    )}
                  </Draggable>
                ))}
                {provided.placeholder}
              </Grid>
            )}
          </Droppable>
        </DragDropContext>
      </Grid>
    </Grid>
  );
};
