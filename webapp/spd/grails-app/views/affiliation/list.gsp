
<%@ page import="com.k_int.spd.domain.Affiliation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'affiliation.label', default: 'Affiliations')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    	<div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1>Affiliations</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'affiliation.user.label', default: 'User')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'affiliation.museum.label', default: 'Museum')}" />
                            
                            <g:sortableColumn property="status" title="${message(code: 'affiliation.status.label', default: 'Status')}" />
                        
                        	<th>Select</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${affiliationInstanceList}" status="i" var="affiliationInstance">
                     	<g:set var="museum_id" value="${fieldValue(bean: affiliationInstance, field: "user.id")}" />
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean: affiliationInstance, field: "user.username")}</td>
                        
                            <td><g:link action="show" controller="museum" id="${affiliationInstance.museum.id}">${fieldValue(bean: affiliationInstance, field: "museum.name")}</g:link></td>
                            
                            <td>${fieldValue(bean: affiliationInstance, field: "status.value")}</td>
                        
                            <td><g:radio name="id" value="${affiliationInstance.id}"/></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${affiliationInstanceTotal}" />
            </div>
            <div class="buttons">
            	<span class="button"><g:actionSubmit class="grant" action="grant" value="Grant" /></span>
            	<span class="button"><g:actionSubmit class="reject" action="reject" value="Reject" /></span>
            	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
			</div>
			</g:form>
        </div>
    </body>
</html>
