class Auction < ActiveRecord::Base
  belongs_to :problem
  belongs_to :winning_bid, class_name: 'Bid', foreign_key: 'winning_bid'
  has_many   :bids

  #after_find :check_if_won

  def current_price
    if winning_bid.nil?
      return problem.base_price
    else
      return winning_bid.amount
    end
  end

  def timer_running?
    return end_time != nil
  end

  def winning_bidder
    if winning_bid.nil?
      return nil
    else
      return winning_bid.user
    end
  end

  def bidding_allowed?(user)
    # Do not allow more than two programs of the same difficulty
    if user.problems.where(difficulty: self.problem.difficulty).size >= 2
      return false
    end

    # Do not allow outbidding yourself
    if winning_bidder == user
      return false
    end

    return true
  end

  def buying_allowed?(user)
    # Do not allow more than two programs of the same difficulty
    if user.problems.where(difficulty: self.problem.difficulty).size >= 2
      return false
    end

    return true
  end

  """
  def check_if_won
    if active == true and time_left != nil and time_left <= 0
      self.update(active: false)

      # Deduct coins from balance
      self.winning_bid.user.update(balance: self.winning_bid.user.balance - self.winning_bid.amount)

      # Add to list of programs
      self.winning_bid.auction.problem.users << self.winning_bid.user

    end
  end
  """

  def time_left
    if end_time == nil
      return nil
    else
      value = (self.end_time - Time.now).round

      if value < 0
        return 0
      else
        return value
      end
    end
  end

  def buy_it_now_price
    return (problem.base_price * 2.5).round
  end
end
