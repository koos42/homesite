//this should be responsible for having the text blurb thing show up on hover over the comic.

if( window.comic === undefined){
  comic = {};
}

comic.setup = function(){
  var blurb = $('#comic #blurb').hide()
  blurb.css('position', 'absolute').css('margin', '30px 0 0 80px');
  $('#photo img').add(blurb).hover(function(){
                          blurb.show();
                        }, 
                        function(){
                          blurb.hide();
                        });
};


$(document).ready(function(){
  comic.setup();
});


