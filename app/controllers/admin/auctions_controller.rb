class Admin::AuctionsController < ApplicationController
  def index
    @auctions = Auction.all
    @next_auction = Auction.where(active: nil).first
    @start_allowed = Auction.find_by_active(true).nil?
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
end
