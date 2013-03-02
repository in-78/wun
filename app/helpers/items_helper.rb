module ItemsHelper
  def get_item_row_class_name item_id, current_item_id
		(item_id == current_item_id) ? "info" : "list"
  end
end