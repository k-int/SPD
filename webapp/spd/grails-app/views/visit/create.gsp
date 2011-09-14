<%@ page import="com.k_int.spd.domain.Visit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'visit.label', default: 'Visit')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
		<div class="body">
		  	<h1>Log Visit</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${museumInstance}">
            <div class="errors">
                <g:renderErrors bean="${museumInstance}" as="list" />
            </div>
            </g:hasErrors>
			<g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="visitDate"><g:message code="visit.visitDate.label" default="Visit Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: visitInstance, field: 'visitDate', 'errors')}">                             
                                    <g:datePicker name="visitDate" value="${visitInstance?.visitDate}" precision="day"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="museum.id"><g:message code="visit.museum.label" default="Museum" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: visitInstance, field: 'region', 'errors')}">
                                    <g:select name="museum.id" from="${com.k_int.spd.domain.Museum.list()}" optionKey="id" optionValue="name" value="${visitInstance?.museum?.name}" noSelection="['null': '']" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="school.id"><g:message code="visit.school.label" default="School" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: visitInstance, field: 'school', 'errors')}">
                                     <g:select name="school.id" from="${com.k_int.spd.domain.School.list()}" optionKey="id" optionValue="name" value="${visitInstance?.school?.name}" noSelection="['null': '']" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="partySize"><g:message code="visit.partySize.label" default="Party Size" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: visitInstance, field: 'partySize', 'errors')}">
                                    <g:textField name="partySize" value="${visitInstance?.partySize}" />
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Add" /></span>
                </div>
            </g:form>
		</div>
    </body>
</html>
    