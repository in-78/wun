class Item < ActiveRecord::Base
  belongs_to :list

  attr_accessible \
  	:complete,
  	:date_due,
  	:date_remind,
  	:description,
  	:name,
  	:star

	validates :name, uniqueness: { case_sensitive: false },
									 presence:   true
end