class Comment < ApplicationRecord
  acts_as_tree order: "created_at ASC"

  ATTRIBUTE_PARAMS = %i(user_id post_id parent_id content).freeze

  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  def belong_to? user
    self.user_id == user.id
  end
end
