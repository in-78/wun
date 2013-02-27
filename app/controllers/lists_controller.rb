class ListsController < ApplicationController
  def index
    @lists = current_user.lists.all
  end

  def show
    @lists = current_user.lists.all

    @list = List.find(params[:id])
    @items = @list.items.all
  end

  def new
    @list = List.new
  end

  def edit
    @lists = current_user.lists.all

    @list = List.find(params[:id])
    @items = @list.items.all
  end

  def create
    @list = current_user.lists.new(params[:list])
    @list.title = params[:title]

    if @list.save
      # redirect_to lists_url(@list, only_path: true), notice: 'Game was successfully created.'
      redirect_to @list, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  def update
    @list = List.find(params[:id])

    if @list.update_attributes(params[:list])
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    redirect_to lists_url
  end
end