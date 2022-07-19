class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.integer :admin
      t.string :name
      t.integer :members, default: []

      t.timestamps
    end
  end
end
