class CreateDailySyncDifferences < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_sync_differences do |t|
      t.references :investigation, null: false, foreign_key: true
      t.date :date
      t.jsonb :differences

      t.timestamps
    end
  end
end
