import axios from 'axios';
import { notifyError } from 'utils/toast/notifyError';
import { UploadFileS3Params } from 'interfaces/api/s3/UploadFileS3Params';

class S3Client {
  /*
    ファイルをS3にアップロードする
    @param file: File アップロードするファイル
    @param preSignedUrl: string アップロード用のPresigned URL
  */
  public async uploadFileS3({ file, preSignedUrl }: UploadFileS3Params): Promise<void> {
    try {
      await axios.put(preSignedUrl, file, {
        headers: {
          'Content-Type': file.type,
        },
      });
    } catch (error) {
      console.error(error);
      notifyError(
        error,
        'ファイルのアップロード中にエラーが発生しました。ファイルの容量が大きすぎる、ファイルを移動されている、通信環境が悪いなどが考えられます。時間を置くかファイルを再度選択してお試しください。'
      );
      throw error;
    }
  }

  /*
    ファイルを全てS3にアップロードする
    @param fileUploadParams: UploadFileS3Params[] アップロードするファイルとPresigned URL
  */
  public async uploadAllFileS3(fileUploadParams: UploadFileS3Params[]): Promise<void> {
    try {
      const uploadPromises = fileUploadParams.map(({ file, preSignedUrl }) =>
        this.uploadFileS3({ file, preSignedUrl })
      );

      await Promise.all(uploadPromises);
    } catch (error) {
      throw error;
    }
  }
}

export const s3Client = new S3Client();
