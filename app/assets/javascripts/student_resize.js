// Handles resizing of buttons when the website is opened on the iPhone for the student views
  window.onload=resizeElements();

  $(window).resize(function(){
    resizeElements();
  });

   // RESIZES ELEMENTS according to screen size (iphone compatibility)
  function resizeElements()
  {
    var newwidth = $(window).width();
    var newheight = $(window).height();  
    // iphone size
    if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent))
    {
      $(".btn-large").css('width', '240px');
      $(".larger-button").css('width', '240px');
    }  
    else
    {
      $(".btn-large").css('width', '380px');
      $(".larger-button").css('width', '600px');
    }
  }
