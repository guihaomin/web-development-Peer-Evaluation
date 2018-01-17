class CreateUserAndGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_and_groups do |t|
      t.integer :userID
      t.integer :groupID

      t.timestamps
    end
  end
end
