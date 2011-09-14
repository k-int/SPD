

<%@ page import="com.k_int.spd.domain.Museum" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'museum.label', default: 'Museum')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${museumInstance}">
            <div class="errors">
                <g:renderErrors bean="${museumInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${museumInstance?.id}" />
                <g:hiddenField name="version" value="${museumInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="oldSpdId"><g:message code="museum.oldSpdId.label" default="Old Spd Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: museumInstance, field: 'oldSpdId', 'errors')}">
                                    <g:textField name="oldSpdId" value="${fieldValue(bean: museumInstance, field: 'oldSpdId')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="region"><g:message code="museum.region.label" default="Region" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: museumInstance, field: 'region', 'errors')}">
                                    <g:select name="region.id" from="${com.k_int.spd.domain.Region.list()}" optionKey="id" value="${museumInstance?.region?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="museum.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: museumInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${museumInstance?.name}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>