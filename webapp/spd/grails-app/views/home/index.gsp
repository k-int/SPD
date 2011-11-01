<html>
    <head>
        <title>Schools Participation Database</title>
        <meta name="layout" content="main"/>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-home').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
      <h1><img src="images/spd.png" /></h1>
      <p>
		<n:isLoggedIn>
	  	Welcome <n:principalName />
	    </n:isLoggedIn>  
		<n:isNotLoggedIn>
		Welcome to the Schools Participation Database, you are not currently logged in. 
		<br/>
		<br/>
		Would you like to <g:link controller="visit" action="search">login</g:link> or <g:link url="register">register</g:link>?
	    </n:isNotLoggedIn>
      </p>
      <div style="margin-top:15px;">
      </div>
      <div class="info1">
      	<p>Generate reports from your data</p>
      </div>
      <div class="info2">
      	<p>Record visits to your Institution</p>
      </div>
    </body>
</html>

