ActiveRecord::Base.transaction do
  ::TestData::PrefectureLoader.load
  puts 'Prefectureのデータを登録しました'
  ::TestData::FishLoader.load
  puts 'Fishのデータを登録しました'
  ::TestData::Supports::ContactLoader.load
  puts 'Supports::Contactのデータを登録しました'
  ::TestData::UserLoader.load
  puts 'Userのデータを登録しました'
end
