
<%@ page import="com.k_int.spd.domain.School" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'school.label', default: 'School')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
        	<h1>Search</h1>
        	<div>
				<g:form method="get" action="search" name="search">
					<li><label for="name">Name </label><input type="text" name="name" id="name" /></li>
					<li><label for="oldSpdId">Legacy ID </label><input type="text" name="oldSpdId" id="oldSpdId" /></li>
					<li><label for="region">Region </label><g:select name="region" from="${regionList}" optionKey="id" optionValue="regionName"></g:select></li>
					<li><input type="submit" value="Go"/></li>
				</g:form>
        	</div>
             <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'school.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="oldSpdId" title="${message(code: 'school.oldSpdId.label', default: 'Old Spd Id')}" />
                        
                            <th><g:message code="school.region.label" default="Region" /></th>
                        
                            <g:sortableColumn property="name" title="${message(code: 'school.name.label', default: 'Name')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${schoolInstanceList}" status="i" var="schoolInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${schoolInstance.id}">${fieldValue(bean: schoolInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: schoolInstance, field: "oldSpdId")}</td>
                        
                            <td>${fieldValue(bean: schoolInstance, field: "region.regionName")}</td>
                        
                            <td>${fieldValue(bean: schoolInstance, field: "name")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${schoolInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
