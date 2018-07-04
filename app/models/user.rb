class User < ApplicationRecord

  ATTRIBUTE_PARAMS = %i(email).freeze

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  
  validates :name, presence: true,
    length: {maximum: Settings.name_maximum_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.email_maximum_length},
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_groups
  has_many :groups, through: :user_groups
  
  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
