// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("turbolinks:load", function() {
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
