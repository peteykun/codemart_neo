var panic_mode = false;
var reload_allowed = true;
var balance;

function reloadContents() {
  if(!reload_allowed)
    return;

  $.get("/auctions.json", function(data) {

    panic_mode = false;

    $('#balance').html(data.balance);
    balance = data.balance;

    if(data.last_archived_auction_present) {
      $('.last_archived_auction_problem_name').html(data.last_archived_auction.problem.name);
      $('.last_archived_auction_winning_bidder_username').html(data.last_archived_auction.winning_bidder.username);
      $('#archived_info').show();
    }

    if(data.active_auctions.length != $('#active_auctions .panel').length)
      panic_mode = true;

    if(data.inactive_auctions.length != $('#inactive_auctions .panel').length)
      panic_mode = true;

    if(!panic_mode) {

      data.active_auctions.forEach(function(auction) {

        if(!panic_mode) {
          the_panel = $("#active_auctions .panel[data-id='" + auction.id + "']");

          if(the_panel.length == 0) {
            // Enter panic mode if we don't find the element
            panic_mode = true;
          }
          else {
            // Update dynamic fields
            the_panel.find('.current_price').html(auction.current_price);
            the_panel.find('.reward').html(auction.problem.reward);
            the_panel.find('.bid-button').data('allowed', auction.bidding_allowed);
            the_panel.find('.buy-button').data('allowed', auction.buying_allowed);
            the_panel.find('input[type=number]').data('min', Math.min(auction.current_price + 10, auction.buy_it_now_price - 10));

            if(Math.min(auction.current_price + 10, auction.buy_it_now_price - 10) > parseInt(the_panel.find('input[type=number]').val()))
              the_panel.find('input[type=number]').val(Math.min(auction.current_price + 10, auction.buy_it_now_price - 10));

            if(auction.timer_running) {
              the_panel.find('.time_left_wrapper').show();
              the_panel.find('.time_left').html('&nbsp;' + auction.time_left);
              the_panel.find('.winning_bidder').html('&nbsp;' + auction.winning_bidder.username);
            } else {
              the_panel.find('.time_left_wrapper').hide();
              the_panel.find('.time_left').html('');
              the_panel.find('.winning_bidder').html('');
            }
          }
        }

      });


      data.inactive_auctions.forEach(function(auction) {

        if(!panic_mode) {
          the_panel = $("#inactive_auctions .panel[data-id='" + auction.id + "']");

          if(the_panel.length == 0) {
            // Enter panic mode if we don't find the element
            panic_mode = true;
          }

          // All fields static, nothing to update
        }

      });
    }

    if(panic_mode) {

      console.log("In panic mode");

      $('#active_auctions').children().remove();

      data.active_auctions.forEach(function(auction) {

          $('#active_auctions').append('<div class="panel panel-primary" data-id="' + auction.id + '">\
            <div class="panel-heading name">' + auction.problem.name + '</div>\
            <div class="panel-body">\
              <b>Read statement:</b>\
              <span class="statement_link"><a href="' + auction.problem.url + '" target="_blank">Click Here</a></span>\
              <br>\
              \
              <b>Current Price:</b>\
              <span class="current_price">' + auction.current_price + '</span> coins\
              <br>\
              \
              <b>Reward:</b>\
              <span class="reward">' + auction.problem.reward + '</span> coins\
              <br>' +

              (auction.timer_running ? '<span class="time_left_wrapper"><b>Winning bidder:</b><span class="winning_bidder">' + auction.winning_bidder.username + '</span><br><b>Time left to bid:</b><span class="time_left">' + auction.time_left + '</span> seconds<br></span>' : '<span class="time_left_wrapper" style="display: none;"><b>Winning bidder:</b><span class="winning_bidder"></span><br><b>Time left to bid:</b><span class="time_left"></span> seconds<br></span>') +
              
              '<br>\
              <b>Make a Bid:</b><br><br>\
              \
              <input type="number" name="amount" class="form-control" value="' + (auction.current_price + 10) + '" data-min="' + (auction.current_price + 10) + '" data-max="' + (auction.buy_it_now_price - 10) + '" readonly><br>\
              \
              <div class="btn-group" role="group" aria-label="add-value">\
                <button type="button" class="btn btn-primary add" data-value="10">+10</button>\
                <button type="button" class="btn btn-primary add" data-value="100">+100</button>\
                <button type="button" class="btn btn-primary add" data-value="1000">+1000</button>\
              </div>\
              \
              <div class="btn-group" role="group" aria-label="sub-value">\
                <button type="button" class="btn btn-danger sub" data-value="10">-10</button>\
                <button type="button" class="btn btn-danger sub" data-value="100">-100</button>\
                <button type="button" class="btn btn-danger sub" data-value="1000">-1000</button>\
              </div>\
              \
              <a class="btn btn-warning bid-button" data-allowed="' + auction.bidding_allowed + '">Bid the above amount</a>\
              <a class="btn btn-success buy-button" data-allowed="' + auction.bidding_allowed + '">Buy it now for ' + auction.buy_it_now_price + ' coins</a>\
            </div>\
          </div>\
          \
          <br>');

      });

      $('#inactive_auctions').children().remove();


      data.inactive_auctions.forEach(function(auction) {

          $('#inactive_auctions').append('<div class="panel panel-default" data-id="' + auction.id + '">\
            <div class="panel-heading name">' + auction.problem.name + '</div>\
            <div class="panel-body">\
              <b>Read statement:</b>\
              <span class="statement_link"><a href="' + auction.problem.url + '" target="_blank">Click Here</a></span>\
              <br>\
              \
              <b>Base Price:</b>\
              <span class="current_price">' + auction.current_price + '</span> coins\
              <br>\
              \
              <b>Reward:</b>\
              <span class="reward">' + auction.problem.reward + '</span> coins\
            </div>\
          </div>\
          \
          <br>');

      });

    }

  });
}

$(function() {
  window.setInterval(function() {
    reloadContents();
  }, 1000);

  $('#active_auctions').on('click', '.add', function() {
    field = $(this).parent().parent().find('input[type=number]');
    field.val(parseInt(field.val()) + $(this).data('value'));

    if(parseInt(field.val()) > balance) {
      field.val(balance);
    }

    if(parseInt(field.val()) > field.data('max')) {
      field.val(field.data('max'));
    }

  });


  $('#active_auctions').on('click', '.sub', function() {
    field = $(this).parent().parent().find('input[type=number]');
    field.val(parseInt(field.val()) - $(this).data('value'));

    if(parseInt(field.val()) < field.data('min')) {
      field.val(field.data('min'));
    }

  });


  $('#active_auctions').on('click', '.bid-button', function() {
    
    if($(this).data('allowed') == true) {

      field = $(this).parent().parent().find('input[type=number]');

      id = parseInt($(this).parent().parent().data('id'));
      amount = parseInt(field.val());

      reload_allowed = false;

      $.post('/auctions/' + id + '/bid.json', { amount: amount }).done(function(data) {
        if(data.success === false) {
          alert(data.message);
        }

        console.log(reload_allowed);
        reload_allowed = true;
        console.log(reload_allowed);
      });

    } else {
      alert("You are not allowed to bid on this!");
    }

  });


  $('#active_auctions').on('click', '.buy-button', function() {
    
    if($(this).data('allowed') == true) {

      field = $(this).parent().parent().find('input[type=number]');

      id = parseInt($(this).parent().parent().data('id'));
      amount = parseInt(field.val());

      reload_allowed = false;

      $.post('/auctions/' + id + '/buy.json', { }).done(function(data) {
        if(data.success === false) {
          alert(data.message);
        }

        reload_allowed = true;
      });

    } else {
      alert("You are not allowed to buy this!");
    }

  });

  balance = parseInt($('#balance').html());

});
