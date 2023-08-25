ActiveAdmin.register PostCategory do
  permit_params :name

  filter :name
  filter :created_at 
end
