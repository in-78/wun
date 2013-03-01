class AddTagToLists < ActiveRecord::Migration
  def change
    add_column :lists, :tag, :integer
  end
end
