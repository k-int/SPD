<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'museum.label', default: 'Museum')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <g:javascript>
      var config

      $(document).ready(function() {	
        $('.nav-report').addClass('active');

        config = loadConfig();

        // Iterate through the axis options adding options to the combo boxes

      });

      function loadConfig() {
        console.log("Loading configuration from ${createLink(controller:'generateReport',action:'config')}");
        var conf
        $.ajax({
          async:false,
          url: "${createLink(controller:'generateReport',action:'config')}",
          success: function(data){
            conf=data;
          }
        });
        return conf;
      }

    </g:javascript>
  </head>
  <body>
    <h1>Report Specification</h1>
    <p>Please note that the report will be created in a new browser window/tab and may take several minutes to render.</p>
    <br/>
    <form target="_new" method="get" >
      <g:hiddenField name="target_config" value="visit"/>
      <table>
        <tr>
          <td colspan="5">Header</td>
        </tr>
      
        <tr>
          <td></td><td colspan="5">X Axis Configuration<br/><select id="x_axis_selection" name="x_axis_name"></select></td></tr>
        </tr>

        <tr><th></th><th></th><th>col1</th><th>col2</th><th>col3</th><th>col4</th></tr>

        <tr>
          <td rowspan="4">Y Axis Configuration<br/><select id="y_axis_configuration" name="y_axis_name"></select></td>
          <th>row1</th>
          <td>---</td>
          <td>---</td>
          <td>---</td>
          <td>---</td>
        </tr>

        <tr><th>row2</th><td>---</td><td>---</td><td>---</td><td>---</td></tr>
        <tr><th>row3</th><td>---</td><td>---</td><td>---</td><td>---</td></tr>
        <tr><th>row4</th><td>---</td><td>---</td><td>---</td><td>---</td></tr>

      </table>
    </form>
  </body>
</html>
