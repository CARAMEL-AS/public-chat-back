class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.string :theme, default: 'LIGHT'
      t.string :language, default: 'ENGLISH'

      t.timestamps
    end
  end
end
