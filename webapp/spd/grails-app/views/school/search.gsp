
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
        	<h1>Search</h1>
			<g:form method="get" action="search" name="search">
				<ul>
					<li><label for="name">Name</label><input type="text" name="name" id="name" class="large" value="${params.name}"/></li>
					<li><label for="oldSpdId">Legacy Id</label><input type="text" name="oldSpdId" id="oldSpdId" class="large" value="${params.oldSpdId}"/></li>
					<li><label for="region">Region</label><g:select name="region" from="${regionList}" optionKey="id" optionValue="regionName" noSelection="['':'']" value="${params.region}" class="large"></g:select></li>
					<li><label for="go"></label><input type="submit" value="Go"/></li>
				</ul>
			</g:form>
            <h1>
            <g:if test="${params.int('offset')}">
		    	Showing results ${params.int('offset') + 1} - ${schoolInstanceTotal < (params.int('max') + params.int('offset')) ? schoolInstanceTotal : (params.int('max') + params.int('offset'))} of ${schoolInstanceTotal}
			</g:if>
			<g:elseif test="${schoolInstanceTotal && schoolInstanceTotal > 0}">
				Showing results 1 - ${schoolInstanceTotal < params.int('max') ? schoolInstanceTotal : params.int('max')} of ${schoolInstanceTotal}
			</g:elseif>
			<g:else>
				Showing ${schoolInstanceTotal} results
			</g:else>
			<g:link class="create button-link flt-right" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
			</h1>
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
                            <td><g:link action="show" id="${schoolInstance.id}" class="edit">${fieldValue(bean: schoolInstance, field: "id")}</g:link></td>
                            <td>${fieldValue(bean: schoolInstance, field: "oldSpdId")}</td>
                            <td>${fieldValue(bean: schoolInstance, field: "region.regionName")}</td>
                            <td>${fieldValue(bean: schoolInstance, field: "name")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate next="&nbsp;" prev="&nbsp;" maxsteps="1" total="${schoolInstanceTotal}" />
            </div>
    </body>
</html>
