
<%@ page import="com.k_int.spd.domain.Museum" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'museum.label', default: 'Museum')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-museum').addClass('active');
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
                <tr>
                    <td valign="top" class="name"><g:message code="museum.id.label" default="Id" /></td>
                    <td valign="top" class="value">${fieldValue(bean: museumInstance, field: "id")}</td>                       
                </tr>
                <tr>
                    <td valign="top" class="name"><g:message code="museum.institutionId.label" default="Institution Id" /></td>
                    <td valign="top" class="value">${fieldValue(bean: museumInstance, field: "institutionId")}</td>   
                </tr>     
                <tr>
                    <td valign="top" class="name"><g:message code="museum.cultureGridInternalId.label" default="CG Internal Id" /></td>
                    <td valign="top" class="value">${fieldValue(bean: museumInstance, field: "cultureGridInternalId")}</td>   
                </tr>     
                <tr>
                    <td valign="top" class="name"><g:message code="museum.oldSpdId.label" default="Legacy Id" /></td> 
                    <td valign="top" class="value">${fieldValue(bean: museumInstance, field: "oldSpdId")}</td>     
                </tr>
                <tr>
                    <td valign="top" class="name"><g:message code="museum.region.label" default="Region" /></td>                            
                    <td valign="top" class="value">${museumInstance?.region?.regionName}</td>   
                </tr>   
                <tr>
                    <td valign="top" class="name"><g:message code="museum.name.label" default="Name" /></td>
                    <td valign="top" class="value">${fieldValue(bean: museumInstance, field: "name")}</td>   
                </tr>    
                <tr>
                    <td valign="top" class="name"><g:message code="museum.postcode.label" default="Postcode" /></td>
                    <td valign="top" class="value">${fieldValue(bean: museumInstance, field: "postcode")}</td>   
                </tr>                   
            </tbody>
        </table>
        <g:form>
            <g:hiddenField name="id" value="${museumInstance?.id}" />
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
