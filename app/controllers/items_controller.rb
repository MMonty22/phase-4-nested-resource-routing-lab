class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user
        render json: user.items
      else
        render json: { error: "user not found"}, status: :not_found
      end
    else
      items = Item.all
      render json: items, include: :user
    end
  end

  def show
    item = Item.find_by(id: params[:id])
    if item
      render json: item, status: :created
    else
      render json: { error: "item not found"}, status: :not_found
    end
  end

  def create
    user = User.find_by(id: params[:user_id])
    user_item = user.items.create(name: "Garden gnomes", description: "No refunds", price: 23)
    if user_item
      render json: user_item, status: :created
    else 
      render json: { error: "user not found"}, status: :not_found
    end
  end

end
