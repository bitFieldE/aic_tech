// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("turbolinks:load", function() {
  $('#new_blog_image').change(function(event){
    initializeFiles();
    // Aquire file object
    var files = event.target.files;
    //console.log($('input[name="blog[new_blog_images][]"]').val());
    let new_blog_image = document.getElementById('new_blog_image');

    for (var i = 0, file; file = files[i]; i++) {
      console.log(new_blog_image.files[i]);

      var reader = new FileReader();

      // If the file isn't a picture,
      if(file.type.indexOf("image") < 0){
        alert("画像ファイルを指定してください。");
        break;
        return false;
      }

      // Set uploaded file
      reader.onload = (function(file){
        return function(event){
          var img =
            '<div class="preview_picture" style="display: inline;">'
              +'<img class="blog_image_prev p-2" style="object-fit: cover; height: 30%; width: 30%;"src="' + event.target.result + '" />'+
            '</div>'

          document.getElementById('new_blog_images_list').innerHTML += img;
        }
      })(file);
      reader.readAsDataURL(file);
    }
    function initializeFiles() {
      document.getElementById('new_blog_images_list').innerHTML = '';
    }

  });
});
