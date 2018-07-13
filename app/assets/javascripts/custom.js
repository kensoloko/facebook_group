$("span.menu").click(function(){
  $(".top-menu ul").slideToggle(300, function(){
  });
});

$(document).on('click', '.comment-form-reply', function(e){
  e.preventDefault();
  var id = $(this).data('id-cm');
  $('.comment-form-'+id).toggle();
});

$(document).on('click', '.post-form-reply', function(e){
  e.preventDefault();
  var id = $(this).data('id-post');
  $('.post-form-'+id).toggle();
});

