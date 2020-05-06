class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :tweets
  # belongs_to :tweet

  validates :content, presence: true

  paginates_per 3

  
end
