class CreateAuthenticationTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :authentication_tokens, id: :uuid do |t|
      t.references :account, foreign_key: true, index: true, type: :uuid
      t.string :token, unique: true, null: false, index: true
      t.string :sign_in_ip
      t.boolean :expired, default: false
      t.timestamps
    end
  end
end
