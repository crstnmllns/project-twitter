ActiveAdmin.register User do

  scope :all
  scope :active
  scope :deactive


  #scope: :cant , -> {where("user_id = #{@tweets.user_id}")}

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment

  permit_params :username, :avatar, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :is_active



       index do
         selectable_column
         id_column
         column :email
         column :username
         column :is_active
         column :tweets do |tweet|
          tweet.tweets.count
        end
        column :likes do |like|
          like.likes.count
        end
        column :tweets do |retweet|
          retweet.tweet_id.count
        end
         actions
       end

    action_item :active, only: :show do
      link_to "Active" , active_admin_user_path(user), method: :put if !user.is_active?
    end

    action_item :deactive, only: :show do
      link_to "Deactive" , deactive_admin_user_path(user), method: :put if user.is_active?
    end



     member_action :active , method: :put do
       user = User.find(params[:id])
       user.update(is_active: true)
       redirect_to admin_user_path(user)
     end

     member_action :deactive , method: :put do
       user = User.find(params[:id])
       user.update(is_active: false)
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
