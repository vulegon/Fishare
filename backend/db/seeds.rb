ActiveRecord::Base.transaction do
  ::TestData::PrefectureLoader.load
end
