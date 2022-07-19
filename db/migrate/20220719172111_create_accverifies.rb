class CreateAccverifies < ActiveRecord::Migration[6.0]
  def change
    create_table :accverifies do |t|
      t.integer :user_id
      t.string :code
      t.boolean :verified

      t.timestamps
    end
  end
end
