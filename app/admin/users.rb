ActiveAdmin.register User do

  scope :all
  scope :active
  scope :deactive

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :username, :avatar, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :is_active

  def activate_account!
   update_attribute :is_active, true
  end

  def deactivate_account!
    update_attribute :is_active, false
  end

    action_item :active, only: :show do
      link_to "Active" , active_admin_user_path(user), method: :put if !user.is_active?
    end

    action_item :deactive, only: :show do
      link_to "Deactive" , deactive_admin_user_path(user), method: :put if user.is_active?
    end

     member_action :active , method: :put do
       user = User.find(params[:id])
       user.update()
       redirect_to admin_user_path(user)
     end

     member_action :deactive , method: :put do
       user = User.find(params[:id])
       user.deactivate_account!
       redirect_to admin_user_path(user)
     end

  #
  # or
  #
  # permit_params do
  #   permitted = [:username, :avatar, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
