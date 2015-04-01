class FreePoolItemsController < ApplicationController
  def index
    @free_pool_items = FreePoolItem.all
  end

  def buy
    @free_pool_item = FreePoolItem.find(params[:free_pool_item_id])

    if current_user.balance < @free_pool_item.problem.base_price 
      redirect_to action: 'index', notice: 'Balance insufficient.'
    elsif current_user.problems.exists? @free_pool_item.problem
      redirect_to action: 'index', notice: 'Problem already purchased.'
    elsif Auction.find_by_active(true) != nil and Auction.find_by_active(true).bids.where(user: current_user).size > 0
      redirect_to action: 'index', notice: 'You cannot purchase this while bidding.'
    else
      current_user.update(balance: current_user.balance - @free_pool_item.problem.base_price)
      current_user.problems << @free_pool_item.problem
      redirect_to action: 'index', notice: "Purchased #{@free_pool_item.problem.name}."
    end
  end
end
