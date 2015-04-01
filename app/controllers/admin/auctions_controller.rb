class Admin::AuctionsController < ApplicationController
  layout 'admin'
  before_action :set_auction, only: [:show, :edit, :update, :destroy]
  
  def index
    @auctions = Auction.all
    @next_auction = Auction.where(active: nil).first
    @start_allowed = Auction.find_by_active(true).nil?
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = ::Auction.new(auction_params)

    @auction.winning_bid = nil
    @auction.end_time    = nil
    @auction.active      = nil

    if @auction.save
      redirect_to admin_auctions_path, notice: 'Auction was successfully created.'
    else
      render :new
    end
  end

  def stop
    @auction = Auction.find(params[:auction_id])
    @auction.update(active: false)

    redirect_to action: 'index'
  end

  def start
    @auction = Auction.find(params[:auction_id])
    @auction.update(active: true)

    redirect_to action: 'index'
  end

  def destroy
    @auction.destroy

    redirect_to admin_auctions_url, notice: 'Problem was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction).permit(:problem_id)
    end
end
