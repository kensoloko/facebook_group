$("span.menu").click(function(){
  $(".top-menu ul").slideToggle(300, function(){
  });
});

$(function () {
// Slideshow 4
  $("#slider4").responsiveSlides({
    auto: true,
    pager:true,
    nav:true,
    speed: 500,
    namespace: "callbacks",
    before: function () {
      $('.events').append("<li>before event fired.</li>");
    },
    after: function () {
      $('.events').append("<li>after event fired.</li>");
    }
  });
});
