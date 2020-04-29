class Tweet < ApplicationRecord
  belongs_to :user
  validates :content , presence: true
  has_many :likes
  has_many :reweets
end
