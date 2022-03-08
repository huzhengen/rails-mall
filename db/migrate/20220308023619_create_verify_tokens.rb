class CreateVerifyTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :verify_tokens do |t|
      t.string :cellphone
      t.string :token
      t.datetime :expired_at

      t.timestamps
    end

    add_index :verify_tokens, [:cellphone, :token]
  end
end
