
<%@ page import="com.k_int.spd.domain.Museum" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'museum.label', default: 'Museum')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'museum.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="oldSpdId" title="${message(code: 'museum.oldSpdId.label', default: 'Old Spd Id')}" />
                        
                            <th><g:message code="museum.region.label" default="Region" /></th>
                        
                            <g:sortableColumn property="name" title="${message(code: 'museum.name.label', default: 'Name')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${museumInstanceList}" status="i" var="museumInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${museumInstance.id}">${fieldValue(bean: museumInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: museumInstance, field: "oldSpdId")}</td>
                        
                            <td>${fieldValue(bean: museumInstance, field: "region")}</td>
                        
                            <td>${fieldValue(bean: museumInstance, field: "name")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${museumInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
