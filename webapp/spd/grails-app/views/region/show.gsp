<%@ page import="com.k_int.spd.domain.Region" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'region.label', default: 'Region')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-region').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
		<h1><g:message code="default.show.label" args="[entityName]" /></h1>
		<g:if test="${flash.message}">
      		<div class="message">${flash.message}</div>
      	</g:if>
		<table>
			<tbody>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="region.id.label" default="Id" /></td>                
         			<td valign="top" class="value">${fieldValue(bean: regionInstance, field: "id")}</td>     
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="region.regionName.label" default="Name" /></td>
	         		<td valign="top" class="value">${fieldValue(bean: regionInstance, field: "regionName")}</td>   
				</tr>
			</tbody>
		</table>
		<g:form>
			<g:hiddenField name="id" value="${regionInstance?.id}" />
			<ul>
				<li>
					<g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
              		<g:link action="list" class="button-link">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
              	</li>
      		</ul>
		</g:form>
    </body>
</html>
