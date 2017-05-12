class CreateSnacks < ActiveRecord::Migration[5.1]
  def change
    create_table :snacks do |t|
      t.string     :name,               unique: :true
      t.string     :purchase_locations, default: ""
      t.integer    :purchase_count,     default: 0
      t.datetime   :last_purchase_date, default: nil
      t.boolean    :optional,           default: false
      t.boolean    :suggested,          default: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
