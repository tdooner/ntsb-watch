ActiveAdmin.register Investigation do
  # Specify parameters which should be permitted for assignment
  permit_params :ntsb_mkey, :completion_status, :event_date, :most_recent_report_type, :contents_raw

  # or consider:
  #
  # permit_params do
  #   permitted = [:ntsb_mkey, :completion_status, :event_date, :most_recent_report_type, :contents_raw]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :ntsb_mkey
  filter :completion_status
  filter :event_date
  filter :most_recent_report_type, as: :select, collection: %w[Prelim Final] + [nil]
  filter :contents_raw_text_cont, as: :string, label: "Contents Raw Contains"
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :ntsb_mkey
    column :completion_status
    column :event_date
    column :most_recent_report_type
    column :contents_raw
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :ntsb_mkey
      row :completion_status
      row :event_date
      row :most_recent_report_type
      row :contents_raw
      row :created_at
      row :updated_at
    end

    table_for(resource.daily_sync_differences) do
      column :date
      column :differences
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :ntsb_mkey
      f.input :completion_status
      f.input :event_date
      f.input :most_recent_report_type
      f.input :contents_raw
    end
    f.actions
  end
end
