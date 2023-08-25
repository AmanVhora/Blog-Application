ActiveAdmin.register Post do
  actions :all, except: %i[new create]
  permit_params :title, :content, :post_image, :post_category_id
  
  index do
    selectable_column
    id_column
    column :title
    column :post_category
    column :likes do |post|
      post.likes.count
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :post_image do |image|
        image_tag(image.post_image, width: 200, height: 150)
      end 
      row :title
      row :content
      row :post_category
      row :likes do |post|
        post.likes.count
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  filter :title
  filter :post_category
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :post_category
      f.input :content
      f.input :post_image, as: :file
      f.actions
    end
  end  
end
