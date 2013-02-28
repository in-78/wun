class ListsController < ApplicationController
  layout "list"

  def index
    @lists = current_user.lists.all
  end

  def show
    get_lists_and_items
  end

  def edit
    get_lists_and_items
  end

  def create
    @list = current_user.lists.new(params[:list])
    @list.title = params[:title]

    if @list.save
      # it doesn't work! (though brakeman recommend) redirect_to lists_url(@list, only_path: true), notice: 'List was successfully created.'
      redirect_to @list, notice: 'List was successfully created.'
    else
      redirect_to lists_url
    end
  end

  def update
    @list = List.find params[:id]

    if @list.update_attributes(params[:list])
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @list = List.find params[:id]
    @list.destroy

    redirect_to lists_url
  end

private
  def get_lists_and_items
    @lists = current_user.lists.all

    @list = List.find params[:id]
    @items = @list.items.all
  end
end