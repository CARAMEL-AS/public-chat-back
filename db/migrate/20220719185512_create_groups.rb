class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :admin
      t.integer :members, array: true, default: []

      t.timestamps
    end
  end
end
