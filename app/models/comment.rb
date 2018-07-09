class Comment < ApplicationRecord

  ATTRIBUTE_PARAMS = %i(user_id post_id content).freeze

  belongs_to :user
  belongs_to :post

  validates :content, presence: true
end
