import AWS from 'aws-sdk'
import S3 from 'aws-sdk/clients/s3'

const accessKeyId = process.env.REACT_APP_S3_ACCESS_KEY_ID; // IAMユーザの認証情報の「アクセスキーID」から確認できます。
const secretAccessKey = process.env.REACT_APP_S3_SECRET_ACCESS_KEY; // IAMユーザのシークレットアクセスキー。アクセスキーを作ったときだけ見れるやつです。
const bucketName = 'fishare-dev'; // 保存先のバケット名
const region = 'ap-northeast-1'; // リージョン

// S3クライアントの設定
const s3 = new S3({
  accessKeyId,
  secretAccessKey,
  region,
})

const bucket = new S3({
  accessKeyId: accessKeyId,
  secretAccessKey: secretAccessKey,
  region: 'ap-northeast-1',
})


class S3Client {
  public async uploadContactFile(file: File): Promise<S3.ManagedUpload.SendData> {
    const uuid = crypto.randomUUID();
    const params: S3.Types.PutObjectRequest = {
      Bucket: bucketName,
      Key: `supports/contact/${uuid}/${file.name}`, // ファイルのS3内でのパス
      Body: file, // ファイルの内容
      ACL: 'public-read', // 誰でもアクセス可能にする設定
      ContentType: file.type, // ファイルのContent-Type
    }

    return s3.upload(params).promise();
  }
}

export const s3Client = new S3Client();
