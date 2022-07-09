class CreateAppwarnings < ActiveRecord::Migration[6.0]
  def change
    create_table :appwarnings do |t|
      t.integer :user_id
      t.integer :count

      t.timestamps
    end
  end
end
