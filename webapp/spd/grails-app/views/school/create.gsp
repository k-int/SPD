

<%@ page import="com.k_int.spd.domain.School" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'school.label', default: 'School')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${schoolInstance}">
            <div class="errors">
                <g:renderErrors bean="${schoolInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="oldSpdId"><g:message code="school.oldSpdId.label" default="Old Spd Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schoolInstance, field: 'oldSpdId', 'errors')}">
                                    <g:textField name="oldSpdId" value="${fieldValue(bean: schoolInstance, field: 'oldSpdId')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="region"><g:message code="school.region.label" default="Region" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schoolInstance, field: 'region', 'errors')}">
                                    <g:select name="region.id" from="${com.k_int.spd.domain.Region.list()}" optionKey="id" value="${schoolInstance?.region?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="school.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schoolInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${schoolInstance?.name}" />
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
