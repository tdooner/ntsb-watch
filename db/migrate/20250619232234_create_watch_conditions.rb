class CreateWatchConditions < ActiveRecord::Migration[8.0]
  def change
    create_table :watch_conditions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :condition_key
      t.string :condition_value

      t.timestamps
    end
  end
end
