//this should be responsible for having the text blurb thing show up on hover over the comic.

if( window.comic === undefined){
  comic = {};
}

comic.setup = function(){

  comic.show_original = function(){
    var original = $('#original').find('.original_link');
    comic.current_url = $('#photo img').attr('src');
    $('#photo img').attr('src', original.attr('href'));
  };

  comic.unshow_original = function(){
    $('#photo img').attr('src', comic.current_url);
  };

  $('#original').
    hover(comic.show_original, comic.unshow_original).
    click(function(){return false;});
};


$(document).ready(function(){
  comic.setup();
});


