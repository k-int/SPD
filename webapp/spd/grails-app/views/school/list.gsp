
<%@ page import="com.k_int.spd.domain.School" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'school.label', default: 'School')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-school').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'school.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="oldSpdId" title="${message(code: 'school.oldSpdId.label', default: 'Legacy Id')}" />
                        
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
                <g:paginate next="&nbsp;" prev="&nbsp;" maxsteps="1" total="${schoolInstanceTotal}"/>
            </div>
    </body>
</html>
