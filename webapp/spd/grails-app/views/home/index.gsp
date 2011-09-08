<html>
    <head>
        <title>Schools Participation Database</title>
        <meta name="layout" content="simmain"/>
    </head>
    <body>
      <h1>Schools Participation Database</h1>
      <p>
		<n:isLoggedIn>
	  	Welcome <n:principalName />, proceed to your <g:link url="secured/home">home page</g:link>
	    </n:isLoggedIn>  
		<n:isNotLoggedIn>
		Welcome to the Schools Participation Database, you are not currently logged in. 
		<br/>
		<br/>
		Would you like to <g:link url="secured/home">login</g:link> or <g:link url="secured/home">register</g:link>?
	    </n:isNotLoggedIn>
      </p>
      <div style="margin-top:15px;">
      </div>
    </body>
</html>

