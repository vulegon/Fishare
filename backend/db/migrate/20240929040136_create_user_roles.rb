class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles, id: :uuid do |t|
      t.integer :role, null: false, comment: '権限'
      t.timestamps
    end
  end
end
