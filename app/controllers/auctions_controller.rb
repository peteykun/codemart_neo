class AuctionsController < ApplicationController
  before_action :set_auction, only: [:show]
  #before_action :check_if_logged_in

  def index
    @active_auctions = Auction.where(active: true).order(:id)
    @inactive_auctions = Auction.where(active: nil).order(:id).limit(5)
  end

  def bid
    new_bid = Bid.new(auction_id: params[:auction_id], user: current_user, amount: params[:amount])
    new_bid.save

    auction = new_bid.auction
    auction.update(winning_bid: new_bid, end_time: Time.now + 60.seconds)

    @active_auctions = Auction.where(active: true).order(:id)
    @inactive_auctions = Auction.where(active: nil).order(:id).limit(5)

    render 'index'
  end

  def buy
    auction = Auction.find(params[:auction_id])
    new_bid = Bid.new(auction: auction, user: current_user, amount: auction.buy_it_now_price)
    new_bid.save

    new_bid.auction.update(winning_bid: new_bid, end_time: Time.now, active: false)

    @active_auctions = Auction.where(active: true).order(:id)
    @inactive_auctions = Auction.where(active: nil).order(:id).limit(5)

    # Deduct coins from balance
    current_user.update(balance: current_user.balance - auction.buy_it_now_price)

    # Add to list of programs
    new_bid.auction.problem.update(user: current_user)

    render 'index'
  end

  private
    # Use callbacks to share common setup or coenstraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end
end
