ActiveRecord::Base.transaction do
  Prefecture.delete_all
  Prefecture.generate_all_prefectures
end
