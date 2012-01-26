

<%@ page import="com.k_int.spd.domain.Museum" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'museum.label', default: 'Museum')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-museum').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
	    <h1><g:message code="default.create.label" args="[entityName]" /></h1>
	    <g:if test="${flash.message}">
	    <div class="message">${flash.message}</div>
	    </g:if>
	    <g:hasErrors bean="${museumInstance}">
	    <div class="errors">
	        <g:renderErrors bean="${museumInstance}" as="list" />
	    </div>
	    </g:hasErrors>
	    <g:form action="save" >
	     <ul>
	     	<li class="value ${hasErrors(bean: museumInstance, field: 'oldSpdId', 'errors')}">
	     		<label for="oldSpdId"><g:message code="museum.oldSpdId.label" default="Legacy Id" /></label>
	     		<g:textField name="oldSpdId" value="${fieldValue(bean: museumInstance, field: 'oldSpdId')}" class="large" />
	     	</li>
	     	<li class="value ${hasErrors(bean: museumInstance, field: 'region', 'errors')}">
	     		<label for="region"><g:message code="museum.region.label" default="Region" /></label>
	     		<g:select name="region.id" from="${com.k_int.spd.domain.Region.list()}" optionKey="id" optionValue="regionName" value="${museumInstance?.region?.id}" noSelection="['null': '']" class="large" />
	    	</li>
	     	<li class="value ${hasErrors(bean: museumInstance, field: 'name', 'errors')}">
	     		<label for="name"><g:message code="museum.name.label" default="Name" /></label>
	     		<g:textField name="name" value="${museumInstance?.name}" class="large" />
	     	</li>
	     	<li class="value ${hasErrors(bean: museumInstance, field: 'postcode', 'errors')}">
                <label for="postcode"><g:message code="museum.postcode.label" default="Postcode" /></label>
                <g:textField name="postcode" value="${museumInstance?.postcode}" class="large" />
            </li>
	     	<li>
	     		<label for="create"></label>
	     		<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
	     		<g:link action="search" class="button-link">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
	     	</li>
	 	</ul>
	    </g:form>
    </body>
</html>
