import { S3Image } from 'interfaces/api/s3';

export interface Contact {
  id: number;
  name: string;
  email: string;
  content: string;
  images: S3Image[];
  contact_category: string;
  created_at: string;
}
