ActiveAdmin.register Comment, as: "Post Comments" do
  actions :all, except: %i[new create]
  permit_params :content

  filter :content
  filter :created_at

  form do |f|
    f.inputs do
      f.input :content
      f.actions
    end
  end 
end
