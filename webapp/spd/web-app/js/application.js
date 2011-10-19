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
});