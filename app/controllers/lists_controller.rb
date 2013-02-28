class ListsController < ApplicationController
  layout "list"

  def index
    @lists = current_user.lists.order_position
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

  def sort
    params[:list].each_with_index do |id, index|
      List.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

private
  def get_lists_and_items
    @lists = current_user.lists.order_position

    @list = List.find params[:id]
    @items = @list.items.order_position
  end
end