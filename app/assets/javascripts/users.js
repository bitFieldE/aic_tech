// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("turbolinks:load", function() {
  /*
  //incremental search
  var users_list = $("tbody");

  function appendUsers(user) {
    var profile_picture = user.profile_picture ? user.profile_picture : 'default_user.png'
    var today = new Date();
    var html =
    `<tr class="shadow all-members">
      <td>
        <img src="${profile_picture}" style="height: 50px; width: 50px; border-radius: 50px; object-fit: cover;">
      </td>
      <td class="name"><a href="/users/${user.id}">${user.name}</td>
      <td>
        ${user.age}
      </td>
      <td class="area">${user.area}</td>
      <td class="occupation">${user.occupation}</td>
      <td class="voice">${user.voice}</td>
    </tr>`
    users_list.append(html);
   }

   function appendErrMsgToHTML(msg) {
       var html = `<tr class="p-4 no-members"><td colspan="7">${msg}</td></tr>`
       users_list.append(html);
  }

  $('.search').on("keyup", function(e) {
    e.preventDefault();

    let input = $('.search-text').val();
    $.ajax({
      type: 'GET',
      url: '/users/search',
      data: { q: input},
      dataType: 'json'
    })
    .done(function(users) {
      console.log(users);
      $("tbody").empty();
      if (users.length !== 0) {
        users.forEach(function(user){
          appendUsers(user);
        });
      }
      else {
        appendErrMsgToHTML("該当する会員はいません");
      }
    })
    .fail(function(users){})
  });
  */

  $('#new_profile_picture').change(function(e){
    // Aquire file object
    var file = e.target.files[0];
    var reader = new FileReader();

    // If the file isn't a picture,
    if(file.type.indexOf("image") < 0){
      alert("画像ファイルを指定してください。");
      return false;
    }

    // Set uploaded file
    reader.onload = (function(file){
      return function(e){
        $("#new_profile_picture_prev").attr("src", e.target.result);
        $("#new_profile_picture_prev").attr("title", file.name);
      };
    })(file);
    reader.readAsDataURL(file);

  });
})
