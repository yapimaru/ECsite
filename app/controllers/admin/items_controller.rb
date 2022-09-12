class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item =Item.new
    @genre = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :price, :introduction, :is_active)
  end
end
