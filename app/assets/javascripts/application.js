// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require_tree .

$(function() {
  $(document).ready(function(e) {
    $('img[usemap]').rwdImageMaps();
  });

  $('.toggle_container').toggle();

  $('.toggle_button').click(function() {
    var id = $(this).attr('data-toggle-id');
    var sel = '.toggle_container[data-toggle-id="' + id + '"]';
    $(sel).toggle();
  });

  $('.pagetop').click(function() {
    $('html, body').animate({scrollTop: 0}, 'slow');
    return false;
  });
});



function commentChange1(){
radio = document.getElementsByName('commentCh')
if(radio[0].checked) {
//フォーム
document.getElementById('pass_check').style.display = "none";
}else if(radio[1].checked) {
//フォーム
document.getElementById('pass_check').style.display = "";
//document.getElementById('secondBox').style.display = "";
}
}
//オンロードさせ、リロード時に選択を保持
window.onload = entryChange1;
