class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible \
  	:email,
  	:password,
  	:password_confirmation,
  	:remember_me,
  	:name

  has_many :lists, dependent: :destroy

	validates :email, uniqueness: { case_sensitive: false },
										presence:   true
  validates :password, presence: true,
  										 length:   { within: 6..30 }
end
