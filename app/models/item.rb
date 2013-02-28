class Item < ActiveRecord::Base
  acts_as_list scope: :list

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

	validates :name, uniqueness: { case_sensitive: false },
									 presence:   true


  searchable do
    text :name, :description
    integer :user_id
  end

  def user_id
    list.user_id
  end
end