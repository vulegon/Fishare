ActiveRecord::Base.transaction do
  ::TestData::PrefectureLoader.load
  ::TestData::Cities::CityLoader.load
end
