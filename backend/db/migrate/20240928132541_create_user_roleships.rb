class CreateUserRoleships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roleships, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid, comment: 'ユーザーID', on_delete: :cascade
      t.references :user_role, null: false, foreign_key: true, type: :uuid, comment: 'ユーザー権限ID', on_delete: :cascade
      t.timestamps
    end

    add_index :user_roleships, %i[user_id user_role_id], unique: true
  end
end
