
<%@ page import="com.k_int.spd.domain.School" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'school.label', default: 'School')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-school').addClass('active');
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
					<td valign="top" class="name"><g:message code="school.id.label" default="Id" /></td>                
         			<td valign="top" class="value">${fieldValue(bean: schoolInstance, field: "id")}</td>     
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="school.oldSpdId.label" default="Legacy Id" /></td>
	         		<td valign="top" class="value">${fieldValue(bean: schoolInstance, field: "oldSpdId")}</td>   
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="school.region.label" default="Region" /></td>
					<td valign="top" class="value">${schoolInstance?.region?.regionName}</td>    
				</tr>
				<tr class="prop">
					<td valign="top" class="name"><g:message code="school.name.label" default="Name" /></td> 
					<td valign="top" class="value">${fieldValue(bean: schoolInstance, field: "name")}</td>  
				</tr>
				<tr class="prop">
                    <td valign="top" class="name"><g:message code="school.edubaseUrn.label" default="Edubase Urn" /></td> 
                    <td valign="top" class="value">${fieldValue(bean: schoolInstance, field: "edubaseUrn")}</td>  
                </tr>
			</tbody>
		</table>
		<g:form>
			<g:hiddenField name="id" value="${schoolInstance?.id}" />
			<ul>
				<li>
					<g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
              		<g:link action="search" class="button-link">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
              	</li>
      		</ul>
		</g:form>
    </body>
</html>
