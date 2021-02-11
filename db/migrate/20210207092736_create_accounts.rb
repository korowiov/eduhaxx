class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :nickname, index: true, unique: true, null: false
      t.string :email, index: true, unique: true, null: false

      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      t.string :password_digest
      t.string :recovery_password_digest

      t.integer :sign_in_count, default: 0, null: false
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
