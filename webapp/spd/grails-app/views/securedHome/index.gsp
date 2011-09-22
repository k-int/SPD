<html>
    <head>
        <title>Schools Participation Database</title>
        <meta name="layout" content="main"/>
    </head>
    <body>
    	<h1>User Home</h1>
		<n:isAdministrator>
			<dl>
				<dt><h2>List</h2></dt>
				<dd><g:link controller="museum" action="list">All Museums</g:link></dd>
				<dd><g:link controller="school" action="list">All Schools</g:link></dd>
				<dd><g:link controller="affiliation" action="list">All Affiliations</g:link></dd>
				<dt><h2>Search</h2></dt>
				<dd><g:link controller="museum" action="search">Museums</g:link></dd>
				<dd><g:link controller="school" action="search">Search Schools</g:link></dd>
				<dt><h2>Create</h2></dt>
				<dd><g:link controller="museum" action="create">New Museum</g:link></dd>
				<dd><g:link controller="school" action="create">New School</g:link></dd>
				<dd><g:link controller="visit" action="create">Log Visit</g:link></dd>
				<dt><h2>Admin</h2></dt>
				<dd><g:link url="/spd/administration/users/list">Admin Area</g:link></dd>
			</dl>	
		</n:isAdministrator>
	</body>
</html>