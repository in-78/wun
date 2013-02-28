class Item < ActiveRecord::Base
  acts_as_list scope: :list

  belongs_to :list

  attr_accessible \
  	:complete,
  	:date_due,
  	:date_remind,
  	:description,
  	:name,
  	:star

  scope :order_position, order(:position)

	validates :name, uniqueness: { case_sensitive: false },
									 presence:   true
end