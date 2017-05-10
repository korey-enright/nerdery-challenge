class CreateSnacks < ActiveRecord::Migration[5.1]
  def change
    create_table :snacks do |t|
      t.string    :name, unique: :true
      t.string    :purchase_locations
      t.datetime  :last_purchase_date
      t.boolean   :optional

      t.timestamps
    end
  end
end
