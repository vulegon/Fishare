class CreateUserRoleships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roleships, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid, comment: 'ユーザーID'
      t.references :user_role, null: false, foreign_key: true, type: :uuid, comment: 'ユーザー権限ID'
      t.timestamps
    end
  end
end
