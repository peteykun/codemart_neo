class Admin::FreePoolItemsController < ApplicationController
  layout 'admin'
  before_action :set_free_pool_item, only: [:show, :edit, :update, :destroy]
  
  def index
    @free_pool_items = FreePoolItem.all.order(:id)
  end

  def new
    @free_pool_item = FreePoolItem.new
  end

  def create
    @free_pool_item = FreePoolItem.new(free_pool_item_params)

    if @free_pool_item.save
      redirect_to admin_free_pool_items_path, notice: 'Auction was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @free_pool_item.destroy

    redirect_to admin_free_pool_items_url, notice: 'Problem was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_free_pool_item
      @free_pool_item = FreePoolItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def free_pool_item_params
      params.require(:free_pool_item).permit(:problem_id)
    end
end
