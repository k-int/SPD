

<%@ page import="com.k_int.spd.domain.Affiliation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'affiliation.label', default: 'Affiliation')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${affiliationInstance}">
            <div class="errors">
                <g:renderErrors bean="${affiliationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="affiliation.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: affiliationInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${com.k_int.spd.domain.User.list()}" optionKey="id" optionValue="username" value="${affiliationInstance?.user?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="museum"><g:message code="affiliation.museum.label" default="Museum" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: affiliationInstance, field: 'museum', 'errors')}">
                                    <g:select name="museum.id" from="${com.k_int.spd.domain.Museum.list()}" optionKey="id" optionValue="name" value="${affiliationInstance?.museum?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
