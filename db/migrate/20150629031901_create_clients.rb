class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :token
      t.string :private_key

      t.timestamps null: false
    end

    add_index :clients, :token, unique: true
    add_index :clients, :private_key, unique: true
  end
end
