json.balance             current_user.balance


json.active_auctions @active_auctions do |auction|
  json.id                auction.id

  json.problem do
    json.id              auction.problem.id
    json.name            auction.problem.name
    json.url             problem_path(auction.problem)
  end

  json.current_price     auction.current_price
  json.buy_it_now_price  auction.buy_it_now_price
  json.timer_running     auction.timer_running?
  json.time_left         auction.time_left

  json.winning_bidder do
    json.username        (if auction.winning_bidder.nil? then nil else auction.winning_bidder.username.titleize end)
  end

  json.bidding_allowed   auction.bidding_allowed?(current_user)
  json.buying_allowed    auction.buying_allowed?(current_user)
end



json.inactive_auctions @inactive_auctions do |auction|
  json.id                auction.id
  
  json.problem do
    json.id              auction.problem.id
    json.name            auction.problem.name
    json.url             problem_path(auction.problem)
  end
  
  json.current_price     auction.current_price
end

