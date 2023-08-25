ActiveAdmin.register Blog do
  actions :all, except: %i[new create]
  permit_params :title, :description, :cover_image
  
  index do
    selectable_column
    id_column
    column :title
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :cover_image do |image|
        image_tag(image.cover_image, width: 200, height: 150)
      end 
      row :title
      row :description
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  filter :title
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :cover_image, as: :file
      f.actions
    end
  end  
end
