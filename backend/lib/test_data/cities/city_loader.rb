require 'csv'

module TestData
  module Cities
    class CityLoader
      CITY_DATA_CSV_PATH = 'lib/test_data/cities/data/KEN_ALL.csv'.freeze

      class << self
        def load
          CSV.foreach(Rails.root.join(CITY_DATA_CSV_PATH), encoding: 'Shift_JIS:UTF-8') do |row|
            prefecture_name = row[6]
            city_name = row[7]

            prefecture = Prefecture.find_by(name: prefecture_name)
            next if prefecture.nil?

            City.find_or_create_by!(
              name: city_name,
              prefecture: prefecture
            )
          end
        end
      end
    end
  end
end
