
<%@ page import="com.k_int.spd.domain.Museum" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'museum.label', default: 'Museum')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-museum').addClass('active');
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
	    	Showing results ${params.int('offset') + 1} - ${museumInstanceTotal < (params.int('max') + params.int('offset')) ? museumInstanceTotal : (params.int('max') + params.int('offset'))} of ${museumInstanceTotal}
		</g:if>
		<g:elseif test="${museumInstanceTotal && museumInstanceTotal > 0}">
			Showing results 1 - ${museumInstanceTotal < params.int('max') ? museumInstanceTotal : params.int('max')} of ${museumInstanceTotal}
		</g:elseif>
		<g:else>
			Showing ${museumInstanceTotal} results
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
		            
		                <g:sortableColumn property="id" title="${message(code: 'museum.id.label', default: 'Id')}" />
		            
		                <g:sortableColumn property="oldSpdId" title="${message(code: 'museum.oldSpdId.label', default: 'Legacy Id')}" />
		            
		                <th><g:message code="museum.region.label" default="Region" /></th>
		            
		                <g:sortableColumn property="name" title="${message(code: 'museum.name.label', default: 'Name')}" />
		            
		            </tr>
		        </thead>
		        <tbody>
		        <g:each in="${museumInstanceList}" status="i" var="museumInstance">
		            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		            
		                <td><g:link action="show" id="${museumInstance.id}" class="edit">${fieldValue(bean: museumInstance, field: "id")}</g:link></td>
		            
		                <td>${fieldValue(bean: museumInstance, field: "oldSpdId")}</td>
		            
		                <td>${fieldValue(bean: museumInstance, field: "region.regionName")}</td>
		            
		                <td>${fieldValue(bean: museumInstance, field: "name")}</td>
		            
		            </tr>
		        </g:each>
		        </tbody>
		    </table>
		</div>
		<div class="paginateButtons">
		    <g:paginate params="${params}" next="&nbsp;" prev="&nbsp;" maxsteps="1" total="${museumInstanceTotal}" />
		</div>
    </body>
</html>
