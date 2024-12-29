import { apiClient } from 'api/v1/apiClient';
import { s3Client } from 'api/v1/s3Client';
import { notifyError } from 'utils/toast/notifyError';
import { generatePreSignedUrls } from 'api/v1/supports/contactImages';
import { UploadFileS3Params } from '../../../interfaces/api/s3/UploadFileS3Params';

/*
  お問い合わせを作成します。
*/
export async function createContact(
  data: {
    name: string,
    email: string
    contactContent: string;
    images: File[];
    contactCategory: string;
  }): Promise<{ message: string }> {
  try {
    const preSignedUrlItems = await generatePreSignedUrls(data.images);
    const uploadFileS3Params = preSignedUrlItems.map((item) => {
      return {
        file: item.file,
        preSignedUrl: item.url,
      };
    });

    await s3Client.uploadAllFileS3(uploadFileS3Params);

    const createContactImages = preSignedUrlItems.map((item, index) => {
      return {
        s3_key: item.s3_key,
        file_name: item.file.name,
        content_type: item.file.type,
        file_size: item.file.size,
        display_order: index,
      };
    });
    const response = await apiClient.post('supports/contact', {
      name: data.name,
      email: data.email,
      content: data.contactContent,
      images: createContactImages,
      contact_category: data.contactCategory,
    });

    const responseData = response.data;
    return { message: responseData.message };
  } catch (error) {
    notifyError(error);
    throw error;
  }
}
