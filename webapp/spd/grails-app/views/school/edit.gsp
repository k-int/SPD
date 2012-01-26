

<%@ page import="com.k_int.spd.domain.School" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'school.label', default: 'School')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-school').addClass('active');
			});
        </g:javascript>
    </head>
    <body> 
        <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
        <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${schoolInstance}">
        <div class="errors">
            <g:renderErrors bean="${schoolInstance}" as="list" />
        </div>
        </g:hasErrors>
                    
        <g:form method="post" >
        <g:hiddenField name="id" value="${schoolInstance?.id}" />
        <g:hiddenField name="version" value="${schoolInstance?.version}" />
        <ul>
			<li class="value ${hasErrors(bean: schoolInstance, field: 'oldSpdId', 'errors')}">
				<label for="oldSpdId"><g:message code="school.oldSpdId.label" default="Legacy Id" /></label>
				<g:textField name="oldSpdId" value="${fieldValue(bean: schoolInstance, field: 'oldSpdId')}" class="large"/>
			</li>
			<li class="value ${hasErrors(bean: schoolInstance, field: 'region', 'errors')}">
				<label for="region"><g:message code="school.region.label" default="Region" /></label>
				<g:select name="region.id" from="${com.k_int.spd.domain.Region.list()}" optionKey="id" optionValue="regionName" value="${schoolInstance?.region?.id}" noSelection="['null': '']" class="large"/>
			</li>
			<li class="value ${hasErrors(bean: schoolInstance, field: 'name', 'errors')}">
				<label for="name"><g:message code="school.name.label" default="Name" /></label>
				<g:textField name="name" value="${schoolInstance?.name}" class="large"/>
			</li>
			<li>Please Note: its vital that any edubaseURN values entered MUST be correct. If unknown this field is best left blank.</li>
            <li class="value ${hasErrors(bean: schoolInstance, field: 'edubaseUrn', 'errors')}">
                <label for="edubaseUrn"><g:message code="school.edubaseUrn.label" default="Edubase URN" /></label>
                <g:textField name="edubaseUrn" value="${schoolInstance?.edubaseUrn}" class="large" />
            </li>
			<li>
				<label for="buttons"></label>
				<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				<g:link action="show" id="${schoolInstance.id}" class="button-link">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
			</li>
    	</ul>
    	</g:form>

    </body>
</html>
