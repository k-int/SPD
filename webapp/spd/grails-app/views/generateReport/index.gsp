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
    <p>Please note that the report will be created in a new browser window/tab and may take several minutes to render.</p>
    <br/>
    <g:form controller="generateReport" action="report" method="get" >
    <g:hiddenField name="target_config" value="visit"/>
    <ul>
	   	<li>
	   		<label for="x_axis_name">X-Axis (Horizontal)</label>
	   		<g:select name="x_axis_name" from="${grailsApplication.config.reportingCfg.visit.reportingAxis.entrySet()}" optionKey="key" optionValue="${{it.value.label}}" class="medium" noSelection="['':'']"/>
	    </li>
	    <li>          		
	   		<label for="y_axis_name">Y-Axis (Vertical)</label>
	   		<g:select name="y_axis_name" from="${grailsApplication.config.reportingCfg.visit.reportingAxis.entrySet()}" optionKey="key" optionValue="${{it.value.label}}" class="medium" noSelection="['':'']"/>
	   	</li>
	   	<li>          		
	   		<label for="omit_zero_sum_rows">Hide empty rows</label>
	   		<g:select name="omit_zero_sum_rows" from="[true,false]" class="medium"/>
	   	</li>
	   	<li>          		
	   		<label for="format">Format</label>
	   		<g:select name="format" from="['html','html(styled)','csv']" class="medium"/>
	   	</li>
	   	<li>
	   	&nbsp;
	   	</li>
	   	<li>
	   		<label for="generateReport"></label>		
	   		<g:link class="button-link button-link-disabled" target="_blank" controller="generateReport" action="report" params="${['target_config':'visit','x_axis_name':'schoolRegion','y_axis_name':'museum']}">Generate Report</g:link>
		</li> 
    </ul>
    </g:form>
    <g:javascript>
	    $(document).ready(function()
		{	
			$('input[type=submit]').attr('disabled', 'disabled');
			
			$('.button-link').click(function(evt)
			{
				if($('select[name="x_axis_name"] option:selected').val().length == 0 
				|| $('select[name="y_axis_name"] option:selected').val().length == 0
				|| $('select[name="x_axis_name"] option:selected').val() == $('select[name="y_axis_name"] option:selected').val())
				{
					evt.preventDefault();
				}			
			});
			
			$('select').change(function()
			{
				var format = ($('select[name="format"] option:selected').val() == 'csv' ? '.csv' : '');
			
				var styled = ($('select[name="format"] option:selected').val() == 'html(styled)' ? '&styled=true' : '');
			
				$('.button-link').attr('href', '/spd/generateReport/report' + format + '?target_config=visit&x_axis_name=' + $('select[name="x_axis_name"] option:selected').val() + '&y_axis_name=' + $('select[name="y_axis_name"] option:selected').val()  + '&omit_zero_sum_rows=' + $('select[name="omit_zero_sum_rows"] option:selected').val() + styled);

				if($('select[name="x_axis_name"] option:selected').val() == $('select[name="y_axis_name"] option:selected').val() 
				|| $('select[name="x_axis_name"] option:selected').val().length == 0 
				|| $('select[name="y_axis_name"] option:selected').val().length == 0)
				{
					$('.button-link').addClass('button-link-disabled');
				}
				else if($('select[name="x_axis_name"] option:selected').val().length > 0 
				&& $('select[name="y_axis_name"] option:selected').val().length > 0)
				{
					$('.button-link').removeClass('button-link-disabled');
				}
			});
		});
    </g:javascript>
	</body>
</html>
