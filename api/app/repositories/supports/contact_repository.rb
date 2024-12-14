module Supports
  class ContactRepository
    # Contactを永続化します
    # @param entity [Supports::Contact] お問い合わせ
    class << self
      def save!(entity)
        entity.save!
        entity.images.each(&:save!)
      end
    end
  end
end
