class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.integer :admin
      t.integer :member

      t.timestamps
    end
  end
end
