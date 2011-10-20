<%@ page import="com.k_int.spd.domain.Affiliation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'affiliation.label', default: 'Affiliations')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
         <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-affiliation').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
		<h1>Affiliations</h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:form>
		<h1>
		<g:if test="${params.int('offset')}">
			Showing results ${params.int('offset') + 1} - ${affiliationInstanceTotal < (params.int('max') + params.int('offset')) ? affiliationInstanceTotal : (params.int('max') + params.int('offset'))} of ${affiliationInstanceTotal}
		</g:if>
		<g:elseif test="${affiliationInstanceTotal > 0}">
			Showing results 1 - ${affiliationInstanceTotal < params.int('max') ? affiliationInstanceTotal : params.int('max')} of ${affiliationInstanceTotal}
		</g:elseif>
		<g:else>
			Showing ${affiliationInstanceTotal} results
		</g:else>
		<g:link class="create button-link flt-right" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
		</h1>     
	         <div class="list">
	             <table>
	                 <thead>
	                     <tr>
	                     	<n:isAdministrator>
	                         <g:sortableColumn property="user.username" title="${message(code: 'affiliation.user.label', default: 'User')}" />
	                     	</n:isAdministrator>
	                         <g:sortableColumn property="museum.name" title="${message(code: 'affiliation.museum.label', default: 'Museum')}" />
	                         <g:sortableColumn property="museum.region.regionName" title="${message(code: 'affiliation.museum.region.label', default: 'Region')}" />         
	                         <g:sortableColumn property="status" title="${message(code: 'affiliation.status.label', default: 'Status')}" />
	                     	<n:isAdministrator>
	                     	<th>Select</th>
	                     	</n:isAdministrator>
	                     </tr>
	                 </thead>
	                 <tbody>
	                 <g:each in="${affiliationInstanceList}" status="i" var="affiliationInstance">
	                  	<g:set var="museum_id" value="${fieldValue(bean: affiliationInstance, field: "user.id")}" />
	                     <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                     	<n:isAdministrator>
	                         <td>${fieldValue(bean: affiliationInstance, field: "user.username")}</td>
	                     	</n:isAdministrator>
	                         <td>
	                         	<n:isAdministrator>
	                         		<g:link action="show" controller="museum" id="${affiliationInstance.museum.id}" class="edit">${fieldValue(bean: affiliationInstance, field: "museum.name")}</g:link>
	                         	</n:isAdministrator>
	                         	<n:lacksRole name="SYSTEM ADMINISTRATOR">
	                         		${fieldValue(bean: affiliationInstance, field: "museum.name")}
	                         	</n:lacksRole>
	                         </td>
	                         <td>${fieldValue(bean: affiliationInstance, field: "museum.region.regionName")}</td>
	                         <td>${fieldValue(bean: affiliationInstance, field: "status.value")}</td>
	                         <n:isAdministrator>
	                         <td><g:radio name="id" value="${affiliationInstance.id}"/></td>
	                         </n:isAdministrator>
	                     </tr>
	                 </g:each>
	                 </tbody>
	             </table>
	         </div>
	         <div class="paginateButtons">
	         	<n:isAdministrator>
	         		<g:actionSubmit class="grant button-link " action="grant" value="Grant" />
	         		<g:actionSubmit class="reject button-link " action="reject" value="Reject" />
	         		<g:actionSubmit class="delete button-link " action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
	        	</n:isAdministrator>  
	        	<g:paginate next="&nbsp;" prev="&nbsp;" maxsteps="1" total="${affiliationInstanceTotal}" />  
	         </div>     
		</g:form>
    </body>
</html>
