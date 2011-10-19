

<%@ page import="com.k_int.spd.domain.Region" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'region.label', default: 'Region')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-region').addClass('active');
			});
        </g:javascript>
    </head>
    <body> 
        <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
        <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${regionInstance}">
        <div class="errors">
            <g:renderErrors bean="${regionInstance}" as="list" />
        </div>
        </g:hasErrors>            
        <g:form method="post" >
        <g:hiddenField name="id" value="${regionInstance?.id}" />
        <g:hiddenField name="version" value="${regionInstance?.version}" />
        <ul>
			<li class="value ${hasErrors(bean: regionInstance, field: 'regionName', 'errors')}">
      			<label for="regionName"><g:message code="region.regionName.label" default="Name" /></label>
      			<g:textField name="regionName" value="${fieldValue(bean: regionInstance, field: 'regionName')}" class="large" />
      		</li>  
			<li>
				<label for="buttons"></label>
				<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				<g:link action="show" id="${regionInstance.id}" class="button-link">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
			</li>
    	</ul>
    	</g:form>

    </body>
</html>
