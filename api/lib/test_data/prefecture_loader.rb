module TestData
  class PrefectureLoader
    PREFECTURES = [
      { name: '北海道', display_order: 1 },
      { name: '青森県', display_order: 2 },
      { name: '岩手県', display_order: 3 },
      { name: '宮城県', display_order: 4 },
      { name: '秋田県', display_order: 5 },
      { name: '山形県', display_order: 6 },
      { name: '福島県', display_order: 7 },
      { name: '茨城県', display_order: 8 },
      { name: '栃木県', display_order: 9 },
      { name: '群馬県', display_order: 10 },
      { name: '埼玉県', display_order: 11 },
      { name: '千葉県', display_order: 12 },
      { name: '東京都', display_order: 13 },
      { name: '神奈川県', display_order: 14 },
      { name: '新潟県', display_order: 15 },
      { name: '富山県', display_order: 16 },
      { name: '石川県', display_order: 17 },
      { name: '福井県', display_order: 18 },
      { name: '山梨県', display_order: 19 },
      { name: '長野県', display_order: 20 },
      { name: '岐阜県', display_order: 21 },
      { name: '静岡県', display_order: 22 },
      { name: '愛知県', display_order: 23 },
      { name: '三重県', display_order: 24 },
      { name: '滋賀県', display_order: 25 },
      { name: '京都府', display_order: 26 },
      { name: '大阪府', display_order: 27 },
      { name: '兵庫県', display_order: 28 },
      { name: '奈良県', display_order: 29 },
      { name: '和歌山県', display_order: 30 },
      { name: '鳥取県', display_order: 31 },
      { name: '島根県', display_order: 32 },
      { name: '岡山県', display_order: 33 },
      { name: '広島県', display_order: 34 },
      { name: '山口県', display_order: 35 },
      { name: '徳島県', display_order: 36 },
      { name: '香川県', display_order: 37 },
      { name: '愛媛県', display_order: 38 },
      { name: '高知県', display_order: 39 },
      { name: '福岡県', display_order: 40 },
      { name: '佐賀県', display_order: 41 },
      { name: '長崎県', display_order: 42 },
      { name: '熊本県', display_order: 43 },
      { name: '大分県', display_order: 44 },
      { name: '宮崎県', display_order: 45 },
      { name: '鹿児島県', display_order: 46 },
      { name: '沖縄県', display_order: 47 }
    ].freeze

    class << self
      def load
        PREFECTURES.each do |prefecture_data|
          Prefecture.find_or_create_by!(
            name: prefecture_data[:name],
            display_order: prefecture_data[:display_order]
          )
        end
      end
    end
  end
end
