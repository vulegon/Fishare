ActiveRecord::Base.transaction do
  ::TestData::PrefectureLoader.load
  puts 'Prefectureのデータを登録しました'
  ::TestData::FishLoader.load
  puts 'Fishのデータを登録しました'
end
