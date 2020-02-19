/*App.messages = App.cable.subscriptions.create("MessagesChannel", {
  connected: function() {
     Called when the subscription is ready for use on the server
    console.log('connected');
  },

  disconnected: function() {
     Called when the subscription has been terminated by the server
  },

  received: function(message) {
     Called when there's incoming data on the websocket for this channel
     let messages        = document.getElementById('messages');
     messages.innerHTML += message;
     console.log('received');
  },

  speak: function(user_id, chat_room_id, content) {
     return this.perform('speak', {
                 "user_id": user_id,
                 "chat_room_id": chat_room_id,
                 "content": content
               });
  }

});

document.addEventListener('DOMContentLoaded', function() {
   let inputContent      = document.getElementById('inputContent');
   let userId            = document.getElementById('userId');
   let chatRoomId        = document.getElementById('chatRoomId');
   let button            = document.getElementById('submit_button');
   button.addEventListener('click', function() {
      let user_id        = userId.value
      console.log(user_id);
      let chat_room_id   = chatRoomId.value
      console.log(chat_room_id);
      let content        = inputContent.value
      console.log(content);

     App.messages.speak(user_id, chat_room_id, content)
     userId.value       = ""
     chatRoomId.value   = ""
     inputContent.value = ""
  });
})
*/
