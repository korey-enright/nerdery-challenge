class CreateSnacks < ActiveRecord::Migration[5.1]
  def change
    create_table :snacks do |t|
      t.string    :name
      t.string    :where_to_purchase
      t.datetime  :last_purchased

      t.timestamps
    end
  end
end
