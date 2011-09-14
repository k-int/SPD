<!-- this gsp is not currently used
<html>
    <head>
        <title>Schools Participation Database</title>
        <meta name="layout" content="main"/>     
    </head>
    <body>
		I am the school index page		
		<p id="message"></p>
		<g:form name="createForm">
			<li><label for="name">Name </label><input type="text" name="name" id="name" /></li>
			<li><label for="oldSpdId">Legacy ID </label><input type="text" name="oldSpdId" id="oldSpdId" /></li>
			<li><label for="region">Region </label><g:select name="region" from="${regionList}" optionKey="id" optionValue="regionName"></g:select></li>
			<li><input type="submit" value="Create"/></li>
		</g:form>
		<g:javascript>
		
		$(document).ready(function()
		{
			$("#createForm").validate(
			{
				submitHandler: function(oForm) 
				{
					alert("about to call : ${createLink(controller:'school', action:'create')}"); 
					
					$.post("${createLink(controller:'school', action:'create')}", $('#createForm').serialize(), function() { })
				    .success(function(data) { alert("success " + JSON.stringify(data)); })
				    .error(function(data) { alert("error " + JSON.stringify(data)); })
				    .complete(function() 
				    { 
				    });	
				}
			});			
		});
		</g:javascript>
	</body>
</html>
-->