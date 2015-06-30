class AddColumnSecretKeyToClient < ActiveRecord::Migration
  def change
    add_column :clients, :secret_key, :string
    add_index  :clients, :secret_key, unique: true
  end
end
