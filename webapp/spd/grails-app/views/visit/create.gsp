<%@ page import="com.k_int.spd.domain.Visit" %>
<%@ page import="com.k_int.spd.domain.Classifier" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'visit.label', default: 'Visit')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-visit').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
	  	<h1>Record Visit</h1>
        <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${museumInstance}">
        <div class="errors">
            <g:renderErrors bean="${museumInstance}" as="list" />
        </div>
        </g:hasErrors>
        <ul>
			<g:form action="save" >
			<li class="value ${hasErrors(bean: visitInstance, field: 'visitDate', 'errors')}">
				<label for="visitDate"><g:message code="visit.visitDate.label" default="Visit Date" /></label>
				<g:datePicker name="visitDate" value="${visitInstance?.visitDate}" precision="day" class="small"/>
			</li>
			<li class="value ${hasErrors(bean: visitInstance, field: 'museum', 'errors')}">
				<label for="museum.id"><g:message code="visit.museum.label" default="Museum" /></label>
				<input type="text" name="museum.name" id="museum_autocomplete" class="large" title="Autocomplete field, type two or more characters... max of 20 results are returned at a time so keep typing to refine the list."/>
			</li>
			<li class="value ${hasErrors(bean: visitInstance, field: 'school', 'errors')}">
				<label for="school.id"><g:message code="visit.school.label" default="School" /></label>
				<input type="text" name="school.name" id="school_autocomplete" class="large" title="Autocomplete field, type two or more characters... max of 20 results are returned at a time so keep typing to refine the list."/>
			</li>
			<li class="value ${hasErrors(bean: visitInstance, field: 'partySize', 'errors')}">
				<label for="partySize"><g:message code="visit.partySize.label" default="Party Size" /></label>
				<g:textField name="partySize" value="${visitInstance?.partySize}" />
			</li>
			<g:each in="${topClassifiers}">
     		<li>
     			<label for="postings" style="vertical-align:top; margin-top:2px"><g:message code="visit.postings.label" default="${it.label}" /></label>
     			
     			<g:select 	id="postings" name='postings' value="${person?.type?.id}"
   							from='${Classifier.findAllByParent(it)}'
   							optionKey="id" optionValue="label" multiple="true" size="4" title="Select multiple values if required" class="large"></g:select>
     			
     		
     		</li>
			</g:each>
			<li>
				<label for="create"></label>
				<g:submitButton name="create" class="save" value="Add" />
				<g:link action="search" class="button-link">${message(code: 'default.button.cancel.label', default: 'Cancel')}</g:link>
			</li>
	        </g:form>
        </ul>
		<g:javascript>
		$(document).ready(function() 
		{
			$('input[title], select').qtip(
			{
				position: 
				{
      				my: 'center left',  // Position my top left...
      				at: 'center right', // at the center right of...
   				},
   				style:
   				{
   					classes: 'ui-tooltip-rounded ui-tooltip-dark'
   				}
			});
					
			$("#school_autocomplete").autocomplete(
			{
				source: function( request, response ) 
				{
					$.getJSON(CONTEXT_PATH + "/school/autocomplete", request, function(data) 
					{
						response(data);
					});
				},
				minLength: 2
			});
		});	
		</g:javascript>
		<n:isAdministrator>
		<g:javascript>
		$(document).ready(function() 
		{
			$("#museum_autocomplete").autocomplete(
			{
				source: function( request, response ) 
				{
					$.getJSON(CONTEXT_PATH + "/museum/autocomplete", request, function(data) 
					{
						response(data);
					});
				},
				minLength: 2
			});
		});
		</g:javascript>
		</n:isAdministrator>
		<n:lacksRole name="SYSTEM ADMINISTRATOR">
		<g:javascript>
		$(document).ready(function() 
		{
			$("#museum_autocomplete").autocomplete(
			{
				source: function( request, response ) 
				{
					$.getJSON(CONTEXT_PATH + "/affiliation/autocomplete", request, function(data) 
					{
						response(data);
					});
				},
				minLength: 2
			});
		});
		</g:javascript>
		</n:lacksRole>
    </body>
</html>
    