<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'museum.label', default: 'Museum')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
         <g:javascript>
        	$(document).ready(function()
			{	
				$('.nav-report').addClass('active');
			});
        </g:javascript>
    </head>
    <body>
    <h1>Reports</h1>
    <p>Please note that the report will be created in a new browser window/tab and may take up to several minutes to render.</p>
    <br/>
	<g:link class="button-link" target="_blank" controller="generateReport" action="report" params="${['target_config':'visit','x_axis_name':'schoolRegion','y_axis_name':'museum']}">Generate Report</g:link></li>
	</body>
</html>
