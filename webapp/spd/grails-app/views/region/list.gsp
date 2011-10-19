<%@ page import="com.k_int.spd.domain.Region" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'region.label', default: 'Region')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-region').addClass('active');
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
		    	Showing results ${params.int('offset') + 1} - ${regionInstanceTotal < (params.int('max') + params.int('offset')) ? regionInstanceTotal : (params.int('max') + params.int('offset'))} of ${regionInstanceTotal}
			</g:if>
			<g:elseif test="${regionInstanceTotal > 0}">
				Showing results 1 - ${regionInstanceTotal < params.int('max') ? regionInstanceTotal : params.int('max')} of ${regionInstanceTotal}
			</g:elseif>
			<g:else>
				Showing ${regionInstanceTotal} results
			</g:else>
			<g:link class="create button-link flt-right" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
			</h1>
            <div class="list">
                <table>
                    <thead>
                        <tr>     
                            <g:sortableColumn property="id" title="${message(code: 'region.id.label', default: 'Id')}" />
                            <g:sortableColumn property="regionName" title="${message(code: 'region.regionName.label', default: 'Name')}" />                     
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${regionInstanceList}" status="i" var="regionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${regionInstance.id}" class="edit">${fieldValue(bean: regionInstance, field: "id")}</g:link></td>
                            <td>${fieldValue(bean: regionInstance, field: "regionName")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate next="&nbsp;" prev="&nbsp;" maxsteps="1" total="${regionInstanceTotal}"/>
            </div>
    </body>
</html>
