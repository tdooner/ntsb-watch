class AddExternalLinkToWatchConditions < ActiveRecord::Migration[8.0]
  def change
    add_column :watch_conditions, :external_link, :string
  end
end
