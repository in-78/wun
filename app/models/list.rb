class List < ActiveRecord::Base
  belongs_to :user

  has_many :items

  attr_accessible :title

  validates :title, presence: true

  def items_count
  	items.count
  end
end