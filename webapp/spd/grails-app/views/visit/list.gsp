
<%@ page import="com.k_int.spd.domain.Visit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'visit.label', default: 'Visit')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-visit').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <h1>
            <g:if test="${params.int('offset')}">
		    	Showing results ${params.int('offset') + 1} - ${visitInstanceTotal < (params.int('max') + params.int('offset')) ? visitInstanceTotal : (params.int('max') + params.int('offset'))} of ${visitInstanceTotal}
			</g:if>
			<g:elseif test="${visitInstanceTotal > 0}">
				Showing results 1 - ${visitInstanceTotal < params.int('max') ? visitInstanceTotal : params.int('max')} of ${visitInstanceTotal}
			</g:elseif>
			<g:else>
				Showing ${visitInstanceTotal} results
			</g:else>
			<g:link class="create button-link flt-right" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
			</h1>            
            <div class="list">
                <table>
                    <thead>
                        <tr>                       
                            <g:sortableColumn property="id" title="${message(code: 'visit.id.label', default: 'Id')}" />                     
                            <g:sortableColumn property="school.name" title="${message(code: 'visit.school.label', default: 'School')}" />
                       		<g:sortableColumn property="museum.name" title="${message(code: 'visit.museum.label', default: 'Museum')}" />
                       		<g:sortableColumn property="visitDate" title="${message(code: 'visit.visitDate.label', default: 'Date')}" />     
                            <g:sortableColumn property="partySize" title="${message(code: 'visit.partySize.label', default: 'Party Size')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${visitInstanceList}" status="i" var="visitInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">            
                            <td>${fieldValue(bean: visitInstance, field: "id")}</td>
                            <td>${fieldValue(bean: visitInstance, field: "school.name")}</td> 
                            <td>${fieldValue(bean: visitInstance, field: "museum.name")}</td>
                            <td><g:formatDate format="dd-MM-yyyy" date="${fieldValue(bean: visitInstance, field: "visitDate")}"/></td>
                            <td>${fieldValue(bean: visitInstance, field: "partySize")}</td>             
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate next="&nbsp;" prev="&nbsp;" maxsteps="1" total="${visitInstanceTotal}"/>
            </div>
    </body>
</html>
