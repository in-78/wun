module ListsHelper
  def get_list_row_class_name is_current
		is_current ? "info" : "list"
  end
end