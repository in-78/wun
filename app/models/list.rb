class List < ActiveRecord::Base
  MARKED = 1
  WEEK = 2
  INPUT = 3

	acts_as_list

  belongs_to :user
  has_many :items

  attr_accessible :title

	scope :order_position, order(:position)

  validates :title, presence: true

  def items_for_show current_user
    if is_marked?
      Item.by_user(current_user).where(star: true)
    elsif is_week?
      Item.by_user(current_user).week
    else
  	  items.order_position
    end
  end

  def items_count current_user
    items_for_show(current_user).count
  end

  def is_marked?
    self.tag == MARKED
  end

  def is_week?
    self.tag == WEEK
  end

  def is_input?
    self.tag == INPUT
  end

  def is_usual?
    self.tag == nil
  end

  def marked
    self.tag = MARKED
  end

  def week
    self.tag = WEEK
  end

  def input
    self.tag = INPUT
  end
end