class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :tweets
  # belongs_to :tweet

  #scope :tweet_amount , -> {where("tweet_id > 0 and  user_id = #{:user_id}")}

  #scope :tweet_amount, ->{joins(:user).where(user_id: @tweet.user_id).count}
  #Tweet.select(:id, :user_id, :tweet_id).where("tweet_id > ?", 0)
  #Tweet.select(:id, :user_id, :tweet_id).where("tweet_id > ?", 0).count(user_id: )
  #Like.where(user_id: 6)



  validates :content, presence: true

  paginates_per 50

  def to_s
    content
  end
end
