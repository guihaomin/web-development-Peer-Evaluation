class CreateEvals < ActiveRecord::Migration[5.1]
  def change
    create_table :evals do |t|
      t.string :comments
      t.integer :score
      t.integer :writerID
      t.integer :recieverID
      t.integer :projectID
      t.integer :groupID

      t.timestamps
    end
  end
end
