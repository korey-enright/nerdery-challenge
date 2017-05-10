class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :snack, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      
      t.timestamps
    end
  end
end
