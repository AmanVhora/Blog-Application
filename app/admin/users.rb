ActiveAdmin.register User do
  actions :all, except: %i[new create]
  permit_params :user_name, :email
  
  index do
    selectable_column
    id_column
    column :user_name
    column :email
    column :created_at
    actions
  end

  filter :user_name
  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user_name
      f.input :email
      f.actions
    end
  end
end
