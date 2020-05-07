class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets , dependent: :destroy
  has_many :likes, dependent: :destroy
  
  scope :active, ->{where.not(is_active: nil)}
  scope :deactive, ->{where(is_active: nil)}


  def activate_account!
   update_attribute :is_active, true
 end

 def deactivate_account!
   update_attribute :is_active, false
 end
end
