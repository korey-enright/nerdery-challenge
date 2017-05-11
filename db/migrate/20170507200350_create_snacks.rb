class CreateSnacks < ActiveRecord::Migration[5.1]
  def change
    create_table :snacks do |t|
      t.string    :name, unique: :true
      t.string    :purchase_locations
      t.integer   :purchase_count
      t.datetime  :last_purchase_date
      t.boolean   :optional
      t.boolean   :suggested

      t.timestamps
    end
  end
end
