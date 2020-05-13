class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets , dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :active, ->{where.not(is_active: nil)}
  scope :deactive, ->{where(is_active: nil)}


  def destroy
      update_attributes(is_active: true) unless is_active
  end

  def active_for_authentication?
      super && is_active
  end


  def is_active
  !self[:is_active].nil? ? self[:is_active] : true 
  end



  end
