import S3 from 'aws-sdk/clients/s3';
import { S3Image } from 'interfaces/api/s3/S3Image';
import { notifyError } from 'utils/toast/notifyError';
import { v4 as uuidv4 } from 'uuid';

// IAMユーザの認証情報の「アクセスキーID」から確認できます。
const accessKeyId = process.env.REACT_APP_S3_ACCESS_KEY_ID;
// IAMユーザのシークレットアクセスキー。アクセスキーを作ったときだけ見れるやつです。
const secretAccessKey = process.env.REACT_APP_S3_SECRET_ACCESS_KEY;
const bucketName = process.env.REACT_APP_S3_BUCKET_NAME ?? ''; // バケット名
const region = process.env.REACT_APP_S3_REGION; // リージョン

// S3クライアントの設定
const s3 = new S3({
  accessKeyId,
  secretAccessKey,
  region,
})

class S3Client {
  public async uploadContactFile(file: File): Promise<S3Image> {
    try {
      const uuid = uuidv4();
      const s3Key = `supports/contact/${uuid}/${file.name}`;
      const params: S3.Types.PutObjectRequest = {
        Bucket: bucketName,
        Key: s3Key, // ファイルのS3内でのパス
        Body: file, // ファイルの内容
        ACL: 'public-read', // 誰でもアクセス可能にする設定
        ContentType: file.type, // ファイルのContent-Type
      }

      await s3.upload(params).promise();

      return {
        s3_key: s3Key,
        file_name: file.name,
        content_type: file.type,
        file_size: file.size,
        s3_url: `https://${bucketName}.s3-${region}.amazonaws.com/${s3Key}`
      };
    } catch (error) {
      notifyError(
        error,
        'ファイルのアップロード中にエラーが発生しました。ファイルの容量が大きすぎる、ファイルを移動されている、通信環境が悪いなどが考えられます。時間を置くかファイルを再度選択してお試しください。'
      );
      throw error;
    }
  }
}

export const s3Client = new S3Client();
