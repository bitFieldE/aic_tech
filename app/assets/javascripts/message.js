$(document).on('turbolinks:load', function(){
  function buildHTML(message) {
    var content = message.content ? `${message.content}` : "";
    var html =
    `<div class="message-wrapper form-inline py-2">
      <div class="pull-left posted_message shadow px-2">${content}</div>
      <p class="created_time p-0 ml-2 mt-3 pull-left">
        ${message.created_at}
      </p>
     </div>`
    if (content){return html;}
  }
  // message post
  $('.message_form').on('submit', function(e){
    e.preventDefault();
    var message = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: message,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.form-submit').attr('disabled', false);
      $('#message_content').val('');
      $('.all_messages').append(html);
      $('.all_messages').animate({scrollTop: $('.all_messages')[0].scrollHeight}, 'fast');
      return false
    })
    .fail(function(data){
      alert('メッセージの送信に失敗しました');
    })
  })

  // automated update
  function refreshingPartial() {
    if (window.location.href.match(/messages/)) {
        $.ajax({
          type: 'GET',
          url: location.href,
          dataType: 'json'
        })
        .done(function(data) {
          $('#messages').empty();
          array = [];

          $.each(data.messages, function(index, message){
            array.push(message)
          });

          alignedMessages = array.sort(function(a,b) {
            return (a.created_at > b.created_at ? 1 : -1);
          });

          $.each(alignedMessages, function(index, message){
            if (message.my_content) {
              var html =
              `<div class="message-wrapper form-inline py-2">
                <div class="pull-left posted_message shadow px-2">${message.my_content}</div>
                 <p class="created_time p-0 ml-2 mt-3 pull-left">
                  ${message.t_created_at}
                 </p>
               </div>`
            } else if(message.matched_content) {
              var html =
              `<div class="message-wrapper form-inline py-2">
                <div class="pull-left received_message shadow px-2">${message.matched_content}</div>
                <p class="created_time p-0 ml-2 mt-3 pull-left">
                  ${message.t_created_at}
                </p>
               </div>`
            }
            $('.all_messages').append(html);
          })

          $('.all_messages').hover(
            function() {
              $('.all_messages').addClass('scroll')
            },
            function() {
              $('.all_messages').removeClass('scroll')
            }
          );
          if (! $('.all_messages').hasClass('scroll')){
            $('.all_messages').animate({scrollTop: $('.all_messages')[0].scrollHeight}, 'fast');
          }
        })
        .fail(function() {
        });
      } else {
        clearInterval(autoReload)
      }
  }
  var time = 3000
  autoReload = setInterval(refreshingPartial, time)
});
