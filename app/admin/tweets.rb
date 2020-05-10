ActiveAdmin.register Tweet do

  permit_params :content, :tweet_id, :user_id



  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #
  index do
    selectable_column
    id_column
    column :content
    column :user_id

    actions
  end

  # or
  #
  # permit_params do
  #   permitted = [:content, :user_id, :tweet_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
