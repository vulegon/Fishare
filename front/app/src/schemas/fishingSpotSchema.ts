import * as z from "zod";

export const fishingSpotSchema = z.object({
  name: z
    .string()
    .min(2, "名前は2文字以上である必要があります")
    .max(50, "名前は100文字以内で入力してください"),
  images: z.array(z.any()).max(9, "画像は最大9枚までです"),
  location: z.object({
    prefecture: z.object({
      id: z.string().nonempty("都道府県を選択してください"),
      name: z.string().nonempty("都道府県名を入力してください"),
    }),
    address: z.string().min(1, "住所を入力してください"),
    latitude: z.number(),
    longitude: z.number(),
  }),
  fish: z
    .array(
      z.object({
        id: z.string(),
        name: z.string(),
      })
    )
    .min(1, "釣れる魚を選択してください"),
  description: z.string().min(10, "説明は10文字以上入力してください"),
});
