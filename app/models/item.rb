class Item < ActiveRecord::Base
  acts_as_list scope: :list
  paginates_per 10

  belongs_to :list
  belongs_to :user

  attr_accessible \
  	:complete,
  	:date_due,
  	:date_remind,
  	:description,
  	:name,
  	:star

  scope :order_position, order(:position)
  scope :by_user, ->(user) { where(list_id: user.lists) }
  scope :week, where("date_due >= :begin_date AND date_due <= :end_date", 
        {begin_date: DateTime.now.beginning_of_week, end_date: DateTime.now.end_of_week})

	validates :name, uniqueness: { case_sensitive: false },
									 presence:   true


  searchable do
    text :name, :description
    integer :user_id
  end

  def user
    list.user if list
  end

  def user_id
    user.id
  end
end