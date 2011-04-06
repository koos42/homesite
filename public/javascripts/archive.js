// this file adds functionality to how the index (archive) functionality
// works.

// setup namespace for this functionality.
if(window.index === undefined){ index = {}; }

index.slide_in = function(sliding_div){
  if(! sliding_div.hidden){
    return;
  }
  sliding_div.button.addClass('selected');
  sliding_div.css('left',$(window).width()).
              css('width','100%').
              css('position', 'absolute').
              show().
              animate({ left: 0,
                        position:'absolute' }, 500,
                function(){
                  sliding_div.show();
                  $('body').css('overflow','auto');
                });
  sliding_div.hidden = false;
};

index.slide_out = function(sliding_div){
  if(sliding_div.hidden){
    return;
  }
  sliding_div.button.removeClass('selected');
  sliding_div.css('left',0).
              css('width','100%').
              css('position', 'absolute').
              animate({ left: $(window).width(),
                        position: 'absolute' }, 500, 
                      function(){ 
                        sliding_div.hide();
                        $('body').css('overflow', 'auto');
                      });
  sliding_div.hidden = true;
};


index.setup_archive = function(){
  index.archive = $('#archive');
  index.archive.button = $('#archive_link a');
  index.archive.hidden = true;

  index.archive.toggle = function(){
  
    if( index.archive.hidden ){
      index.slide_out(index.about);
      index.slide_in(index.archive);
    } else {
      index.slide_out(index.archive);
    }
  };

  index.archive.show_comic = function(opts){
    var id_to_show = null;

    if(opts !== undefined || opts !== null && opts['id'] !== undefined ){
      // if we have an id to turn on, turn the comic to it...
      id_to_show = opts['id'];
      index.archive.swap_in_comic(id_to_show);
    }
    // else just make sure that the comic is turned on...
    archive.unhide_comic();
  };

  // setup next and prev buttons.
  index.archive.setup_next_prev_buttons = function(id){
    var next_id = index.archive.find('#' + id).next().attr('id');
    var prev_id = index.archive.find('#' + id).prev().attr('id');
    
    if( typeof next_id !== undefined && next_id !== '' && next_id != 'place_holder') {
      $('#comic #next a').unbind().click(function(){ index.archive.swap_in_comic(next_id); return false;}).show();
    } else {
      $('#comic #next a').unbind().hide();
    }

    if( typeof prev_id !== undefined && prev_id !== '' && prev_id != 'place_holder') {
      $('#content #prev a').unbind().click(function(){ index.archive.swap_in_comic(prev_id); return false;}).show();
    } else {
      $('#content #prev a').unbind().hide();
    }
  };

  index.archive.swap_in_comic = function(id){
    var comic_img_link = $('#archive #' + id + ' .img_links .full'); 
    var comic_src = $('#archive #' + id + ' .comic_info');
    var comic_dst = $('#comic');

    comic_dst.find('#photo img').attr('src',comic_src.find('.full').attr('href'));

    comic_dst.find('#title').text(comic_src.find('.title').text());
    comic_dst.find('#date').text(comic_src.find('.date').text());
    comic_dst.find('#blurb *').remove();
    comic_dst.find('#blurb').append(comic_src.find('.blurb').clone());
    comic_dst.find('.controls').replaceWith(comic_src.find('.controls').clone());

    index.archive.setup_next_prev_buttons(id);
  };


  index.archive.unhide_comic = function(){
    $('#comic').removeClass('hidden');
  };
  
  // go through all of the archive links and set them up so that when clicked
  // they do a show comic, with their own id.
  index.archive.setup_links = function(){
    $('.archive_comic').each(function(doesnt_matter,comic){
      var comic_id = $(comic).attr('id');
      var comic_thumb = $(comic).find('.comic_info .thumb').attr('href');
      var comic_title = $(comic).find('.comic_info .title').text();

      // hide the link name.
      $(comic).find('.show').hide();

      $(comic).append('<img src="' + comic_thumb + '" />');
      $(comic).append('<div class="bubble">' + comic_title + '</div>');
      var bubble = $(comic).find('.bubble')
      bubble.hide();

      $(comic).click(function(){
          //fucking closures rock!!!!
          index.slide_out(index.archive);
          index.archive.show_comic({ 'id' : comic_id });
          return false;
        }).
        mouseover(function(e){
          //fucking closures still rock!!!!
          bubble.show();
        }).
        mouseout(function(e){
          //fucking closures rock even more!!!!
          bubble.hide();
        });

      $(comic).css('float', 'left').
               css('clear', 'none');
    });
  };
  
  index.archive.setup_toggle_on_click = function(){
    // setup the onclick to toggle the hide and show of the archive.
    index.archive.button.click(function(){
      index.archive.toggle();
      return false;
    });
  };
};



index.setup_about = function(){
  // this is all wrapped in a function so it can happen after the page is rendered;
  index.about = $("#about");
  index.about.button = $("#about_link a");
  index.about.hidden = true;
  index.about.toggle = function(){
    index.about.removeClass('hidden');
    if(index.about.hidden){
      index.slide_out(index.archive);
      index.slide_in(index.about);
    } else {
      index.slide_out(index.about);
    }
  };
  index.about.button.click(function(){
    index.about.toggle();
    return false;
  });
};



index.setup = function(){
  index.setup_about();
  index.setup_archive();
  
  // hide the archive...
  index.archive.hide();

  //unhide the comic...
  index.archive.swap_in_comic($('.archive_comic').last().attr('id'));
  index.archive.unhide_comic();

  //setup archive links.
  index.archive.setup_links();
  index.archive.setup_toggle_on_click();
};

$(document).ready(function(){
  index.setup();
});
