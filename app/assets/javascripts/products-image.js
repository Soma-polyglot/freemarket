$(function() {
  $('img.owl-dot').mouseover(function(){
  var selectedSrc = $(this).attr('src').replace(/^(.+)_thumb(\.gif|\.jpg|\.png+)$/, "$1"+"$2");
  $('img.owl-lazy').stop().fadeOut(50,
  function(){
  $('img.owl-lazy').attr('src', selectedSrc);
  $('img.owl-lazy').stop().fadeIn(200);
  }
  );
  $(this).css({"border":"1px solid #fff"});
  });
  $('img.owl-dot').mouseout(function(){
  $(this).css({"border":""});
  });
});


