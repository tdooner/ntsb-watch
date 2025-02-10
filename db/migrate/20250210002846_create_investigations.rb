class CreateInvestigations < ActiveRecord::Migration[8.0]
  def change
    create_table :investigations do |t|
      t.integer :ntsb_mkey, null: false
      t.string :completion_status
      t.timestamp :event_date
      t.string :most_recent_report_type
      t.jsonb :contents_raw

      t.index :ntsb_mkey, unique: true

      t.timestamps
    end
  end
end
