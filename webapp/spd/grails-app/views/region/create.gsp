<%@ page import="com.k_int.spd.domain.Region" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'region.label', default: 'Region')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-region').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
		<h1><g:message code="default.create.label" args="[entityName]" /></h1>
		<g:if test="${flash.message}">
      		<div class="message">${flash.message}</div>
      	</g:if>
      	<g:hasErrors bean="${regionInstance}">
      		<div class="errors">
        		<g:renderErrors bean="${regionInstance}" as="list" />
      		</div>
      	</g:hasErrors>
     	<g:form action="save" >
      		<ul>
      			<li class="value ${hasErrors(bean: regionInstance, field: 'regionName', 'errors')}">
      				<label for="regionName"><g:message code="region.regionName.label" default="Name" /></label>
      				<g:textField name="regionName" value="${fieldValue(bean: regionInstance, field: 'regionName')}" class="large" />
      			</li>        		
      			<li>
      				<label for="create"></label>
      				<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
      				<g:link action="list" class="button-link">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
      			</li>
      		</ul>
      	</g:form>
    </body>
</html>