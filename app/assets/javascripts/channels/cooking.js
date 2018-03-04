(function() {
  jQuery(document).on('turbolinks:load', function() {
    return App.chat = App.cable.subscriptions.create({
      channel: "CookingChannel"
    }, {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        if (data.message.oven.id) {
          $("#ready_" + data.message.oven.id).removeClass('hidden')
          $("#take_em_out_" + data.message.oven.id).addClass('hidden')
        }
      },
      send_message: function(message) {}
    });
  });
}).call(this);
