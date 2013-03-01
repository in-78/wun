class ListsController < LoginController
  layout "list"

  before_filter :get_lists_and_items, only: [:show, :edit]
  before_filter :find_list, only: [:update, :destroy]

  def index
    @lists = current_user.lists.order_position
  end

  def show
  end

  def edit
  end

  def create
    @list = current_user.lists.new title: params[:title]

    if @list.save
      # it doesn't work! (though brakeman recommend) redirect_to lists_url(@list, only_path: true), notice: 'List was successfully created.'
      redirect_to @list, notice: 'List was successfully created.'
    else
      flash[:error] = "Name is required"
      redirect_to lists_url
    end
  end

  def update
    if @list.update_attributes(params[:list])
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_url
  end

  def sort
    update_position params[:list]
    render nothing: true
  end

private
  def get_lists_and_items
    @list = List.find params[:id]
    check_owner @list

    @lists = current_user.lists.order_position
    @items = @list.items_for_show(current_user).page params[:page]
  end

  def find_list
    @list = List.find params[:id]
    check_owner @list
  end

  def update_position position_list
    position_list.each_with_index do |id, index|
      List.update_all({position: index+1}, {id: id})
    end
  end

  def check_owner list
    if list.user != current_user
      redirect_to lists_path
    end
  end
end