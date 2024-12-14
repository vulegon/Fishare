module Supports
  class ContactImageRepository
    # ContactImageを永続化します
    # @param entity [Supports::ContactImage] お問い合わせ画像
    class << self
      def save_all!(entity)
        entity.each(&:save!)
      end
    end
  end
end
