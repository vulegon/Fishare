ActiveRecord::Base.transaction do
  ::TestData::PrefectureLoader.load
  ::TestData::FishLoader.load
end
