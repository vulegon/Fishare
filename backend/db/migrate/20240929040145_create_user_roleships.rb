class CreateUserRoleships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roleships, id: :uuid, comment: 'ユーザーと権限を管理する交差テーブル'  do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid, comment: 'ユーザーID'
      t.references :user_role, null: false, foreign_key: true, type: :uuid, comment: 'ユーザー権限ID'
      t.timestamps
    end

    add_index :user_roleships, %i[user_id user_role_id], unique: true, name: 'index_user_roleships_on_user_id_and_user_role_id_unique'
  end
end
