class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :image
      t.timestamp :created_at
      t.timestamp :last_login
    end
  end
end
