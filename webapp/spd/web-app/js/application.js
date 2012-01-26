/* start of google analytics code */
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-17380719-11']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' :
'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0];
s.parentNode.insertBefore(ga, s);
})();
/* end of google analytics code */

var Ajax;
if (Ajax && (Ajax != null)) {
	Ajax.Responders.register({
	  onCreate: function() {
        if($('spinner') && Ajax.activeRequestCount>0)
          Effect.Appear('spinner',{duration:0.5,queue:'end'});
	  },
	  onComplete: function() {
        if($('spinner') && Ajax.activeRequestCount==0)
          Effect.Fade('spinner',{duration:0.5,queue:'end'});
	  }
	});
}

function resizeFrame()  
{ 
	var nav_height = $('#nav-outer').height();
	var footer_height = $('#footer-outer').height();
	
    var content_height = $(window).height() - (nav_height + footer_height + 18 + 10); //18 is the overlap of the nav links  + 10 for bottom padidng
    
    $("#content").css('minHeight', content_height < 400 ? 400 : content_height); 
} 

$(window).resize(function() 
{
	resizeFrame();
});

$(document).ready(function()
{	
	resizeFrame();
	
	$('#footer-inner').prepend('<img src="' + CONTEXT_PATH + '/images/col_trust_small.png"/>');
});

