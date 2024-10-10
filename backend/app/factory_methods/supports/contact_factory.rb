module Supports
  class ContactFactory
    # Contactをビルドします。永続化は行いません。
    # @param params [Api::V1::Supports::Contacts::CreateParameter] お問い合わせ作成パラメータ
    # @return [Supports::Contact] 永続化されていないお問い合わせ
    def build(params)
      contact_id = SecureRandom.uuid
      ::Supports::Contact.new(
        id: contact_id,
        name: params.name,
        email: params.email,
        content: params.content,
        support_contact_category_id: params.support_contact_category.id
      )
    end
  end
end
