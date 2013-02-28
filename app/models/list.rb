class List < ActiveRecord::Base
	acts_as_list

  belongs_to :user
  has_many :items

  attr_accessible :title

	scope :order_position, order(:position)

  validates :title, presence: true

  def items_count
  	items.count
  end
end