class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  def to_s
    id
  end

end
