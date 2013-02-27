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
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(params[:item])

    if @item.save
      # redirect_to items_url(@item, only_path: true), notice: 'Item was successfully created.'
      redirect_to :back, notice: 'Item was successfully created.'
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
    @item.destroy

    redirect_to items_url
  end
end