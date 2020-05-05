class Tweet < ApplicationRecord
  belongs_to :user
  validates :content , presence: true
  has_many :likes , dependent: :destroy
  belongs_to :tweet



  paginates_per 50

end
