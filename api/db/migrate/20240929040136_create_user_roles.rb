class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles, id: :uuid, comment: 'ユーザーの権限'  do |t|
      t.integer :role, null: false, comment: '権限'
      t.timestamps
    end

    add_index :user_roles, :role, unique: true, name: 'index_user_roles_on_role_unique'
  end
end
