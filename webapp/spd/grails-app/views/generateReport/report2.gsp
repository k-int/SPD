<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'museum.label', default: 'Museum')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <g:javascript>
      $(document).ready(function() {	
        $('.nav-report').addClass('active');
      });
    </g:javascript>
  </head>
  <body>
    <h1>Report Specification</h1>
    <p>Please note that the report will be created in a new browser window/tab and may take several minutes to render.</p>
    <br/>
    <form target="" method="get" >
      <g:hiddenField name="target_config" value="visit"/>
      <table>
        <tr>
          <td colspan="2">Header</td>
        </tr>
      
        <tr>
          <td></td><td>X Axis Configuration</td></tr>
        </tr>

        <tr>
          <td>Y Axis Configuration</td>
          <td>Main Report Configuration</td>
        </tr>

      </table>
    </form>
  </body>
</html>
