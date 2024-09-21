module TestData
  class PrefectureLoader
    PREFECTURES = [
      { name: '北海道', sort: 1 },
      { name: '青森県', sort: 2 },
      { name: '岩手県', sort: 3 },
      { name: '宮城県', sort: 4 },
      { name: '秋田県', sort: 5 },
      { name: '山形県', sort: 6 },
      { name: '福島県', sort: 7 },
      { name: '茨城県', sort: 8 },
      { name: '栃木県', sort: 9 },
      { name: '群馬県', sort: 10 },
      { name: '埼玉県', sort: 11 },
      { name: '千葉県', sort: 12 },
      { name: '東京都', sort: 13 },
      { name: '神奈川県', sort: 14 },
      { name: '新潟県', sort: 15 },
      { name: '富山県', sort: 16 },
      { name: '石川県', sort: 17 },
      { name: '福井県', sort: 18 },
      { name: '山梨県', sort: 19 },
      { name: '長野県', sort: 20 },
      { name: '岐阜県', sort: 21 },
      { name: '静岡県', sort: 22 },
      { name: '愛知県', sort: 23 },
      { name: '三重県', sort: 24 },
      { name: '滋賀県', sort: 25 },
      { name: '京都府', sort: 26 },
      { name: '大阪府', sort: 27 },
      { name: '兵庫県', sort: 28 },
      { name: '奈良県', sort: 29 },
      { name: '和歌山県', sort: 30 },
      { name: '鳥取県', sort: 31 },
      { name: '島根県', sort: 32 },
      { name: '岡山県', sort: 33 },
      { name: '広島県', sort: 34 },
      { name: '山口県', sort: 35 },
      { name: '徳島県', sort: 36 },
      { name: '香川県', sort: 37 },
      { name: '愛媛県', sort: 38 },
      { name: '高知県', sort: 39 },
      { name: '福岡県', sort: 40 },
      { name: '佐賀県', sort: 41 },
      { name: '長崎県', sort: 42 },
      { name: '熊本県', sort: 43 },
      { name: '大分県', sort: 44 },
      { name: '宮崎県', sort: 45 },
      { name: '鹿児島県', sort: 46 },
      { name: '沖縄県', sort: 47 }
    ].freeze

    class << self
      def load
        PREFECTURES.each do |prefecture_data|
          Prefecture.find_or_create_by!(
            name: prefecture_data[:name],
            sort: prefecture_data[:sort]
          )
        end
      end
    end
  end
end
