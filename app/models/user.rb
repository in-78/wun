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
  has_many :items, through: :lists

	validates :email, uniqueness: { case_sensitive: false },
										presence:   true
  validates :password, presence: true,
  										 length:   { within: 6..30 }

  after_create :create_default_lists

  protected
  def create_default_lists
    titles = ['input', 'marked', 'week', 'private', 'buy', 'films', 'work', 'wish list']
    titles.each do |title|
      default_list = lists.new(title: title)
      case title
        when 'input'
          default_list.input
        when 'week'
          default_list.week
        when 'marked'
          default_list.marked
      end
      default_list.save!
    end
  end
end