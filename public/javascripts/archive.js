// this file adds functionality to how the index (archive) functionality
// works.

// setup namespace for this functionality.
if(window.archive === undefined){ archive = {}; }

archive = {};
archive.show_comic = function(opts){
  var id_to_show = null;

  if(opts !== undefined || opts !== null && opts['id'] !== undefined ){
    // if we have an id to turn on, turn the comic to it...
    id_to_show = opts['id'];
    archive.swap_in_comic(id_to_show);
  }
  // else just make sure that the comic is turned on...
  archive.unhide_comic();
};

archive.swap_in_comic = function(id){
  var comic_img_link = $('#archive #' + id + ' .img_links .full'); 
  var comic_src = $('#archive #' + id + ' .comic_info');
  var comic_dst = $('#comic');

  comic_dst.find('#photo img').attr('src',comic_src.find('.full').attr('href'));

  comic_dst.find('#title').text(comic_src.find('.title').text());
  comic_dst.find('#date').text(comic_src.find('.date').text());
  comic_dst.find('#blurb').text(comic_src.find('.blurb').text());
  comic_dst.find('.controls').replaceWith(comic_src.find('.controls').clone());
}

archive.unhide_comic = function(){
  $('#comic').removeClass('hidden');
}

archive.toggle = function(){
  $('#archive').toggle();
};

archive.setup = function(){
  
  // hide the archive...
  $('#archive').hide();// addClass('hidden');
  
  // setup the onclick to toggle the hide and show of the archive.
  $('#archive_link').click(function(){
    archive.toggle();
    return false;
  });
  
  // go through all of hte archive links and set them up so that when clicked
  // they do a show comic, with their own id.
  $('.archive_comic').each(function(index,comic){
    var comic_id = $(comic).attr('id');

    $(comic).find('a.show').click(function(){
      archive.toggle();
      archive.show_comic({ 'id' : comic_id });
      return false;
    });
  });
  archive.unhide_comic();
};

$(document).ready(function(){
  archive.setup();
});
