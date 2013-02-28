class ItemsController < ApplicationController
  def edit
    @lists = current_user.lists.order_position

    @item = Item.find params[:id]
    @list = @item.list
    @items = @list.items.all
  end

  def create
    @list = List.find params[:list]

    params[:star] ||= false
    @item = @list.items.new(name: params[:name], date_due: params[:date_due], star: params[:star])

    notice = @item.save ? 'Item was successfully created.' : ''
    redirect_to @list, notice: notice
  end

  def update
    @item = Item.find(params[:id])
    @list = @item.list

    if @item.update_attributes(params[:item])
      redirect_to @list, notice: 'Item was successfully updated.'
    else
      redirect_to edit_item_path
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @list = @item.list
    @item.destroy

    redirect_to @list
  end
end