class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @params = params
    @item = Item.new
  end

  def edit
    @lists = current_user.lists.all
    @item = Item.find(params[:id])
    @list = List.find(@item.list.id)
    @items = @list.items.all
  end

  def create
    @list = List.find(params[:list])
    @item = @list.items.new()
    @item.name = params[:name]
    @item.date_due = params[:date_due]
    @item.star = 'yes' ? true : false

    if @item.save
      redirect_to @list, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        redirect_to @item, notice: 'Item was successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @list = @item.list
    @item.destroy

    redirect_to @list
  end
end