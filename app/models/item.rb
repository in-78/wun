class Item < ActiveRecord::Base
  belongs_to :list
  attr_accessible :complete, :date_due, :date_remind, :description, :name, :star
end
