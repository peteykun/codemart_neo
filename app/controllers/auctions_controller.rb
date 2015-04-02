class AuctionsController < ApplicationController
  before_action :set_auction, only: [:show]
  before_action :check_if_logged_in

  def index
    @last_archived_auction = Auction.where(active: false).order('id DESC').first
    @active_auctions       = Auction.where(active: true).order(:id)
    @inactive_auctions     = Auction.where(active: nil).order(:id).limit(5)
  end

  def bid

    $lock.synchronize("bid_lock") do

      auction = Auction.find(params[:auction_id])

      if auction.time_left != nil and auction.time_left <= 0
        
        @success = false
        @message = "The auction has ended."

      elsif params[:amount].to_i > current_user.balance

        @success = false
        @message = "Insufficient balance."

      else

        new_bid = Bid.new(auction_id: params[:auction_id], user: current_user, amount: params[:amount])
        new_bid.save

        auction = new_bid.auction
        auction.update(winning_bid: new_bid, end_time: Time.now + 60.seconds)

        @success = true
        @message = "Bid successfully."

      end

    end

  end

  def buy

    $lock.synchronize("expiry_lock") do

      auction = Auction.find(params[:auction_id])
      
      if auction.time_left != nil and auction.time_left <= 0
        
        @success = false
        @message = "The auction has ended."


      elsif auction.buy_it_now_price > current_user.balance
        
        @success = false
        @message = "Insufficient balance."

      else

        new_bid = Bid.new(auction: auction, user: current_user, amount: auction.buy_it_now_price)
        new_bid.save

        new_bid.auction.update(winning_bid: new_bid, end_time: Time.now, active: false)

        # Deduct coins from balance
        current_user.update(balance: current_user.balance - auction.buy_it_now_price)

        # Add to list of programsW
        new_bid.auction.problem.users << current_user

        @success = true
        @message = "Purchased successfully."

      end
    end

  end

  private
    # Use callbacks to share common setup or coenstraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end
end
