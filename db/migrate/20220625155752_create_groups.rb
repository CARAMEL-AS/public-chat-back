class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.string :group_name
      t.string :group_code
      t.integer :member_ids, array: true, default: []
      t.string :messages, array: true, default: []
      t.string :banned_member_ids, array: true, default: []
    end
  end
end
