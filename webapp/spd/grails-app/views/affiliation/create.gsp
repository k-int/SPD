<%@ page import="com.k_int.spd.domain.Affiliation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'affiliation.label', default: 'Affiliation')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
         <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-affiliation').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
        <h1><g:message code="default.create.label" args="[entityName]" /></h1>
        <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${affiliationInstance}">
        <div class="errors">
             <g:renderErrors bean="${affiliationInstance}" as="list" />
        </div>
        </g:hasErrors>
        <g:form action="save" >
        <n:lacksRole name="SYSTEM ADMINISTRATOR">
        	 <g:hiddenField name="user.id" value="${userInstance?.id}" />
        </n:lacksRole>
		<ul>
			<n:isAdministrator>	
			<li class="value ${hasErrors(bean: affiliationInstance, field: 'user', 'errors')}">
				<label for="user"><g:message code="affiliation.user.label" default="User"/></label>
				<g:select name="user.id" from="${com.k_int.spd.domain.User.list()}" optionKey="id" optionValue="username" value="${affiliationInstance?.user?.id}" noSelection="['null': '']" class="large"/>
			</li>
			</n:isAdministrator>   
			<li class="value ${hasErrors(bean: affiliationInstance, field: 'museum', 'errors')}">
				<label for="museum"><g:message code="affiliation.museum.label" default="Museum"/></label>
				<input type="text" name="museum.name" id="museum_autocomplete" class="large" title="Autocomplete field, type two or more characters..."/>
			</li>
			<li>
				<label for="create"></label><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				<g:link action="list" class="button-link">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
			</li>
		</ul>         
        </g:form>
        <g:javascript>
		$(document).ready(function() 
		{
			$('input[title]').qtip(
			{
				position: 
				{
      				my: 'center left',  // Position my top left...
      				at: 'center right', // at the center right of...
   				},
   				style:
   				{
   					classes: 'ui-tooltip-rounded ui-tooltip-dark'
   				}
   			});
   				
			$("#museum_autocomplete").autocomplete(
			{
				source: function( request, response ) 
				{
					$.getJSON(CONTEXT_PATH + "/museum/autocomplete", request, function(data) 
					{
						response(data);
					});
				},
				minLength: 2
			});
		});
		</g:javascript>
    </body>
</html>
