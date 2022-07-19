class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :image, default: ''
      t.boolean :online, default: true
      t.string :username, default: Faker::FunnyName.two_word_name
      t.boolean :status, default: true
    end
  end
end
