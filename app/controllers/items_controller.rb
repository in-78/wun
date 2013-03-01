class ItemsController < ApplicationController
  autocomplete :item, :name

  before_filter :get_lists, only: [:index, :edit]
  before_filter :find_item, only: [:edit, :update, :destroy]

  def get_autocomplete_items(params)
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
    @list = @item.list
    @items = @list.items.order_position.page params[:page]
  end

  def create
    @list = List.find params[:list]

    params[:star] ||= false
    @item = @list.items.new(name: params[:name], date_due: params[:date_due], star: params[:star])

    notice = @item.save ? 'Item was successfully created.' : ''
    redirect_to @list, notice: notice
  end

  def update
    @list = @item.list

    if @item.update_attributes(params[:item])
      redirect_to @list, notice: 'Item was successfully updated.'
    else
      redirect_to edit_item_path
    end
  end

  def destroy
    @list = @item.list
    @item.destroy

    redirect_to @list
  end

  def sort
    update_position params[:list]
    render nothing: true
  end

private
  def get_lists
    @lists = current_user.lists.order_position
  end

  def find_item
    @item = Item.find params[:id]
  end

  def update_position position_list
    position_list.each_with_index do |id, index|
      Item.update_all({position: index+1}, {id: id})
    end
  end
end