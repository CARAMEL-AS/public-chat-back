class CreateSocialauths < ActiveRecord::Migration[6.0]
  def change
    create_table :socialauths do |t|
      t.string :email
      t.string :username
      t.string :image
      t.boolean :online, default: true
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
