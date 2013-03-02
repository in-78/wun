class ItemsController < LoginController
  autocomplete :item, :name

  before_filter :get_lists, only: [:index, :edit]
  before_filter :find_item_and_list, only: [:edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to lists_path
  end

  def get_autocomplete_items params
    super(params).by_user current_user
  end

  def index
    @items = Item.search do
      fulltext params[:search]
      with(:user_id, current_user.id)
      paginate page: params[:page],  per_page: 10
    end.results

    render layout: 'list'
  end

  def edit
    @items = @list.items.order_position.page params[:page]
  end

  def create
    @list = List.find params[:list]

    params[:star] ||= false
    @item = @list.items.new(name: params[:name], date_due: params[:date_due], star: params[:star])
    check_for_marked_list @list, @item

    notice = @item.save ? 'Item was successfully created.' : ''
    redirect_to @list, notice: notice
  end

  def update
    if @item.update_attributes(params[:item])
      redirect_to @list, notice: 'Item was successfully updated.'
    else
      redirect_to edit_item_path
    end
  end

  def destroy
    @item.destroy

    redirect_to @list
  end

  def sort
    update_position params[:list]
    render nothing: true
  end

  def complete
    update_complete_item params[:id], params[:complete]
    render nothing: true
  end

private
  def get_lists
    @lists = current_user.lists.order_position
  end

  def find_item_and_list
    @item = current_user.items.find params[:id]
    @list = @item.list
  end

  def update_position position_list
    position_list.each_with_index do |id, index|
      Item.update_all({position: index+1}, {id: id})
    end
  end

  def check_for_marked_list list, item
    if list.is_marked?
      item.list = current_user.lists.find_by_tag 3
      item.star = true
    end
  end

  def update_complete_item id, complete_str
    Item.update_all({complete: complete_str == 'true'}, {id: id})
  end
end