ActiveAdmin.register WatchCondition do
  # Specify parameters which should be permitted for assignment
  permit_params :user_id, :condition_key, :condition_value, :external_link

  controller do
    def new
      @watch_condition = WatchCondition.new(user: current_user)
    end
  end

  # or consider:
  #
  # permit_params do
  #   permitted = [:user_id, :condition_key, :condition_value]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :user
  filter :condition_key, as: :select, collection: WatchCondition::VALID_KEYS
  filter :condition_value
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :user
    column :condition_key
    column :condition_value
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :user
      row :condition_key
      row :condition_value
      row :external_link
      row :created_at
      row :updated_at
    end

    active_admin_comments_for(resource)
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :user, as: :select, collection: User.all.map { |u| [u.email, u.id] }, default: current_user.id
      f.input :condition_key, as: :select, collection: WatchCondition::VALID_KEYS
      f.input :condition_value
      f.input :external_link
    end
    f.actions
  end
end
