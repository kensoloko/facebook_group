class User < ApplicationRecord

  ATTRIBUTE_PARAMS = %i(email).freeze

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :name, presence: true,
    length: {maximum: Settings.name_maximum_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.email_maximum_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  before_save :downcase_email

  def join? group
    groups.include? group
  end

  def leave group
    user_groups.delete group
  end

  def is_group_creator? group
    self.id != group.creator_id
  end

  def is_post_owner? comment
    post = Post.find_by id: comment.post_id
    self.id == post.user_id
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
