class ItemsController < ApplicationController
  def edit
    @lists = current_user.lists.all

    @item = Item.find params[:id]
    @list = @item.list
    @items = @list.items.all
  end

  def create
    @list = List.find params[:list]

    params[:star] ||= false
    @item = @list.items.new(name: params[:name], date_due: params[:date_due], star: params[:star])

    if @item.save
      redirect_to @list, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    @list = @item.list

    if @item.update_attributes(params[:item])
      redirect_to @list, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @list = @item.list
    @item.destroy

    redirect_to @list
  end

end