import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    console.log("Conencted to chatroom_channel")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    $('#message-container').append(data.mod_message);
    scroll_bottom();
    // alert(data.foo);
    // chatroom = document.getElementById('chatroom');

  // chatroom.innerHTML +=
  //   "<h2>" + data.body + "</h2>";
    // Called when there's incoming data on the websocket for this channel
    // alert data.foo
  }
});
