namespace :auctions do
  desc "TODO"
  task check_expiry: :environment do

    $lock.synchronize("expiry_lock") do
      active_auction = Auction.find_by_active(true)

      if active_auction != nil
        if active_auction.time_left != nil and active_auction.time_left <= 0
          active_auction.update(active: false)

          # Deduct coins from balance
          active_auction.winning_bid.user.update(balance: active_auction.winning_bid.user.balance - active_auction.winning_bid.amount)

          # Add to list of programs
          active_auction.winning_bid.auction.problem.users << active_auction.winning_bid.user

        end
      end
    end

  end

end
